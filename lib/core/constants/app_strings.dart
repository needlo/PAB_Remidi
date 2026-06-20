class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'SpaceNews Core';
  static const String appTagline = 'Advanced International News Portal';

  // API
  static const String apiBaseUrl = 'https://api.spaceflightnewsapi.net/v4';

  // Welcome Screen
  static const String welcomeTitle = 'Welcome to SpaceNews Core';
  static const String welcomeSubtitle =
      'Stay updated with the latest space flight news from around the world. Explore articles, save your favorites, and never miss a story.';

  // Auth Screens
  static const String loginTitle = 'Welcome Back';
  static const String loginSubtitle = 'Sign in to your account to continue';
  static const String registerTitle = 'Create Account';
  static const String registerSubtitle = 'Sign up to get started with SpaceNews Core';
  static const String forgotPasswordTitle = 'Reset Password';
  static const String forgotPasswordSubtitle =
      'Enter your email address and we\'ll send you a link to reset your password';

  // Labels
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String fullNameLabel = 'Full Name';
  static const String instagramLabel = 'Instagram Username';
  static const String profileImageLabel = 'Profile Image URL';

  // Hints
  static const String emailHint = 'Enter your email address';
  static const String passwordHint = 'Enter your password';
  static const String confirmPasswordHint = 'Re-enter your password';
  static const String fullNameHint = 'Enter your full name';
  static const String instagramHint = 'Enter your Instagram username';
  static const String profileImageHint = 'Enter your profile image URL';

  // Buttons
  static const String loginButton = 'Sign In';
  static const String registerButton = 'Sign Up';
  static const String logoutButton = 'Sign Out';
  static const String forgotPasswordButton = 'Send Reset Link';
  static const String getStartedButton = 'Get Started';
  static const String tryAgainButton = 'Try Again';
  static const String saveButton = 'Save';
  static const String cancelButton = 'Cancel';
  static const String readMoreButton = 'Read More';
  static const String viewAllButton = 'View All';
  static const String updateProfileButton = 'Update Profile';

  // Navigation
  static const String homeNav = 'Home';
  static const String favoritesNav = 'Favorites';
  static const String notificationsNav = 'Notifications';
  static const String profileNav = 'Profile';

  // Sections
  static const String headlineSection = 'Headline';
  static const String latestNewsSection = 'Latest News';
  static const String favoritesSection = 'My Favorites';
  static const String notificationsSection = 'Notifications';
  static const String profileSection = 'Profile';

  // Messages
  static const String noArticlesMessage = 'No articles available at the moment.';
  static const String noFavoritesMessage = 'You haven\'t saved any favorites yet.';
  static const String noNotificationsMessage = 'No notifications at this time.';
  static const String loadingMessage = 'Loading...';
  static const String refreshingMessage = 'Refreshing...';

  // Success Messages
  static const String loginSuccess = 'Successfully signed in!';
  static const String registerSuccess = 'Account created successfully!';
  static const String logoutSuccess = 'Successfully signed out.';
  static const String resetPasswordSuccess = 'Password reset link sent to your email.';
  static const String profileUpdateSuccess = 'Profile updated successfully!';
  static const String addFavoriteSuccess = 'Added to favorites!';
  static const String removeFavoriteSuccess = 'Removed from favorites.';

  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'No internet connection. Please check your network.';
  static const String serverError = 'Server error. Please try again later.';
  static const String invalidEmailError = 'Please enter a valid email address.';
  static const String emptyEmailError = 'Email address is required.';
  static const String emptyPasswordError = 'Password is required.';
  static const String shortPasswordError = 'Password must be at least 6 characters.';
  static const String passwordMismatchError = 'Passwords do not match.';
  static const String emptyNameError = 'Full name is required.';
  static const String userNotFoundError = 'No account found with this email.';
  static const String wrongPasswordError = 'Incorrect password. Please try again.';
  static const String emailInUseError = 'An account already exists with this email.';
  static const String weakPasswordError = 'Password is too weak. Use at least 6 characters.';
  static const String fetchArticlesError = 'Failed to load articles. Please try again.';

  // Links
  static const String dontHaveAccount = 'Don\'t have an account? ';
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String forgotPassword = 'Forgot Password?';
}
