from django.contrib.auth.models import User
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from .models import UserProfile

REGISTER_URL = reverse('register')


def register_payload(**overrides):
    data = {
        'username': 'newuser',
        'email': 'newuser@example.com',
        'password': 'StrongPass123!',
        'role': 'farmer',
        'phone': '+1234567890',
    }
    data.update(overrides)
    return data


class RegisterEndpointTests(APITestCase):

    def test_register_farmer_creates_user_and_profile(self):
        response = self.client.post(
            REGISTER_URL, register_payload(), format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_201_CREATED, response.data)

        user = User.objects.get(username='newuser')
        self.assertEqual(user.email, 'newuser@example.com')
        self.assertTrue(user.check_password('StrongPass123!'))
        self.assertNotEqual(user.password, 'StrongPass123!')

        profile = UserProfile.objects.get(user=user)
        self.assertEqual(profile.role, 'farmer')
        self.assertEqual(profile.phone, '+1234567890')

        self.assertEqual(response.data['username'], 'newuser')
        self.assertEqual(response.data['email'], 'newuser@example.com')
        self.assertNotIn('password', response.data)

    def test_register_accepts_both_roles_and_optional_phone(self):
        for role in ['farmer', 'business']:
            with self.subTest(role=role):
                username = f'user_{role}'
                data = register_payload(
                    username=username,
                    email=f'{role}@example.com',
                    role=role,
                )
                data.pop('phone')

                response = self.client.post(REGISTER_URL, data, format='json')

                self.assertEqual(
                    response.status_code, status.HTTP_201_CREATED, response.data
                )
                profile = UserProfile.objects.get(user__username=username)
                self.assertEqual(profile.role, role)
                self.assertEqual(profile.phone, '')

    def test_blank_phone_is_allowed(self):
        response = self.client.post(
            REGISTER_URL, register_payload(phone=''), format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_201_CREATED, response.data)
        self.assertEqual(
            UserProfile.objects.get(user__username='newuser').phone, ''
        )

    def test_duplicate_email_is_rejected_case_insensitively(self):
        User.objects.create_user(
            username='existing',
            email='Existing@Example.com',
            password='AnotherPass123!',
        )

        response = self.client.post(
            REGISTER_URL,
            register_payload(username='another', email='existing@example.com'),
            format='json',
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('email', response.data)
        self.assertIn('already registered', str(response.data['email']))
        self.assertFalse(User.objects.filter(username='another').exists())

    def test_duplicate_username_is_rejected(self):
        User.objects.create_user(
            username='newuser',
            email='other@example.com',
            password='AnotherPass123!',
        )

        response = self.client.post(REGISTER_URL, register_payload(), format='json')

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('username', response.data)

    def test_password_shorter_than_eight_characters_is_rejected(self):
        response = self.client.post(
            REGISTER_URL, register_payload(password='short'), format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('password', response.data)

    def test_missing_required_fields_are_rejected(self):
        for field in ['username', 'password', 'role']:
            with self.subTest(missing=field):
                data = register_payload()
                data.pop(field)

                response = self.client.post(REGISTER_URL, data, format='json')

                self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
                self.assertIn(field, response.data)

    def test_invalid_role_is_rejected(self):
        response = self.client.post(
            REGISTER_URL, register_payload(role='admin'), format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('role', response.data)

    def test_invalid_email_format_is_rejected(self):
        response = self.client.post(
            REGISTER_URL, register_payload(email='not-an-email'), format='json'
        )

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('email', response.data)

    def test_non_post_methods_are_not_allowed(self):
        for method in ['get', 'put', 'patch', 'delete']:
            with self.subTest(method=method):
                response = getattr(self.client, method)(REGISTER_URL)

                self.assertEqual(
                    response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED
                )
