/// Centralized UI text for Doko.
///
/// Every screen should reference these constants instead of typing text
/// directly inline — this is what makes English/Nepali localization
/// (Section 1.10, Non-Functional Requirements) realistic to add later:
/// once everything reads from here, adding Nepali is a matter of creating
/// a second version of this file (or migrating these into lib/l10n/*.arb
/// files for real runtime language-switching), not hunting through every
/// screen individually.
class AppStrings {
  AppStrings._();

  // --- App-wide ---
  static const String appName = 'Doko';
  static const String appTagline = 'Fresh from farm to your shelf, every morning';

  // --- Auth: role selection ---
  static const String chooseRole = 'How will you use Doko?';
  static const String roleShopOwner = 'I own a shop';
  static const String roleShopOwnerSubtitle = 'Buy fresh, directly from local farms';
  static const String roleFarmer = "I'm a farmer";
  static const String roleFarmerSubtitle = 'Sell your harvest to nearby shops';
  static const String continueAsShopOwner = 'Continue as shop owner';
  static const String continueAsFarmer = 'Continue as farmer';

  // --- Auth: login ---
  static const String login = 'Log in';
  static const String welcomeBack = 'Welcome back.';
  static const String welcomeBackSubtitle = 'Your next fresh connection is right here.';
  static const String usernameOrEmail = 'Username/Email';
  static const String password = 'Password';
  static const String rememberMe = 'Remember Me';
  static const String forgotPassword = 'Forgot password?';
  static const String newToDoko = 'New to Doko?';
  static const String createAccount = 'Create an account';
  static const String alreadyHaveAccount = 'Already have an account?';

  // --- Auth: registration ---
  static const String shopOwnerRegisterTitle = 'Fresh starts for your shop.';
  static const String shopOwnerRegisterSubtitle =
      'Buy fresh, buy local. Connect directly with farmers near you.';
  static const String farmerRegisterTitle = 'Let your farm grow further.';
  static const String farmerRegisterSubtitle =
      'Sell straight to local shops. Fewer middlemen, better returns.';
  static const String fullName = 'Full name';
  static const String shopName = 'Shop name';
  static const String farmName = 'Farm name';
  static const String mobileNumber = 'Mobile number';
  static const String shopAddress = 'Shop address';
  static const String farmLocation = 'Farm location';
  static const String whatDoYouGrow = 'What do you grow?';
  static const String createPassword = 'Create a password';
  static const String confirmPassword = 'Confirm password';
  static const String passwordHint = 'Use at least 8 characters, including a number';
  static const String agreeToTerms = 'I agree to Doko\'s Terms of service and Privacy policy';
  static const String createShopAccount = 'Create shop account';
  static const String createFarmAccount = 'Create farm account';

  // --- Marketplace (shop owner) ---
  static const String goodMorning = 'Good morning'; // append name, e.g. "$goodMorning, Asha"
  static const String searchProduceOrFarmers = 'Search produce or farmers';
  static const String allProduce = 'All produce';
  static const String vegetables = 'Vegetables';
  static const String fruits = 'Fruits';
  static const String freshFromNearbyFarms = 'Fresh from nearby farms';
  static const String comparePrices = 'Compare local farmers';
  static const String yourQuantity = 'Your quantity';
  static const String addToCart = 'Add to cart';
  static const String minimumOrder = 'Min order';

  // --- Orders ---
  static const String orderConfirmed = 'Order confirmed';
  static const String freshnessOnItsWay = 'Freshness is on its way.';
  static const String yourOrder = 'Your order';
  static const String produceSubtotal = 'Produce subtotal';
  static const String farmDelivery = 'Farm delivery';
  static const String payOnDelivery = 'Pay on delivery';
  static const String repeatThisOrder = 'Repeat this order';
  static const String viewMyOrders = 'View my orders';
  static const String myOrders = 'My orders';
  static const String arrivingTomorrow = 'Arriving tomorrow';
  static const String yourWeeklyEssentials = 'Your weekly essentials';
  static const String recentlyDelivered = 'Recently delivered';
  static const String reorder = 'Reorder';
  static const String skipNext = 'Skip next';
  static const String pauseOrder = 'Pause order';

  // --- Order status labels (paired with StatusBadge) ---
  static const String statusPending = 'Pending';
  static const String statusConfirmed = 'Confirmed';
  static const String statusPacked = 'Packed';
  static const String statusInTransit = 'In transit';
  static const String statusDelivered = 'Delivered';
  static const String statusDeclined = 'Declined';

  // --- Farmer: profile & dashboard ---
  static const String meetYourFarmer = 'Meet your farmer';
  static const String followFarm = 'Follow farm';
  static const String message = 'Message';
  static const String fromTheFarm = 'From the farm';
  static const String allUpdates = 'All updates';
  static const String seasonalListings = 'seasonal listings';
  static const String hello = 'Hello'; // append name, e.g. "$hello, Maya"
  static const String confirmedSalesThisWeek = 'Confirmed sales this week';
  static const String readyForTomorrow = 'Ready for tomorrow';
  static const String startPacking = 'Start packing';
  static const String addProduceListing = 'Add produce listing';

  // --- Farmer: produce inventory & listing form ---
  static const String myProduce = 'My produce';
  static const String editProduce = 'Edit produce';
  static const String produceName = 'Produce name';
  static const String priceRs = 'Price (Rs)';
  static const String unit = 'Unit';
  static const String expectedStockKg = 'Expected stock (kg)';
  static const String minimumOrderKg = 'Minimum order (kg)';
  static const String availability = 'Availability';
  static const String availableNow = 'Available now';
  static const String preOrder = 'Pre-order';
  static const String unavailable = 'Unavailable';
  static const String markAsSurplus = 'Mark as surplus';
  static const String notesForShopOwners = 'Notes for shop owners';
  static const String saveChanges = 'Save changes';

  // --- Farmer: incoming orders ---
  static const String incomingOrders = 'Incoming orders';
  static const String accept = 'Accept';
  static const String acceptOrder = 'Accept order';
  static const String acceptPreOrder = 'Accept pre-order';
  static const String decline = 'Decline';
  static const String markAsPacked = 'Mark as packed';

  // --- Account (shared + role-specific) ---
  static const String myAccount = 'My account';
  static const String myFarm = 'My farm';
  static const String editProfile = 'Edit profile';
  static const String ordersPlaced = 'Orders placed';
  static const String farmsFollowed = 'Farms followed';
  static const String repeatOrders = 'Repeat orders';
  static const String followedFarms = 'Followed farms';
  static const String deliveryAddresses = 'Delivery addresses';
  static const String notificationsAndPreferences = 'Notifications & preferences';
  static const String helpAndSupport = 'Help & support';
  static const String logOut = 'Log out';
  static const String paymentsAndEarnings = 'Payments & earnings';

  // --- Common / shared across screens ---
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String back = 'Back';
  static const String viewAll = 'View all';
  static const String viewOrder = 'View order';
  static const String manage = 'Manage';
  static const String seeAll = 'See all';
  static const String loading = 'Loading...';
  static const String tryAgain = 'Try again';
  static const String somethingWentWrong = 'Something went wrong. Please try again.';
  static const String noInternetConnection = 'No internet connection';

  // --- Validation messages (Section 1.9, Functional Requirements) ---
  static const String fieldRequired = 'This field is required';
  static const String fillAllRequiredFields = 'Please fill in all required fields';
  static const String invalidPhoneNumber = 'Please enter a valid phone number';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String enterValidQuantity = 'Please enter a valid quantity';
  static const String priceCannotBeNegative = 'Price cannot be negative';
  static const String mustAgreeToTerms = 'You must agree to the Terms of Service to continue';
}