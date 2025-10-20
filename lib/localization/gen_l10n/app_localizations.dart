import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}!'**
  String greeting(Object name);

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout'**
  String get connectionTimeout;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @requestWasCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled'**
  String get requestWasCancelled;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @unexpectedErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error occurred'**
  String get unexpectedErrorOccurred;

  /// No description provided for @the_application_has_encountered_an_unknown_error.
  ///
  /// In en, this message translates to:
  /// **'The application has encountered an unknown error.'**
  String get the_application_has_encountered_an_unknown_error;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get try_again;

  /// No description provided for @no_items_found.
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get no_items_found;

  /// No description provided for @the_list_is_currently_empty.
  ///
  /// In en, this message translates to:
  /// **'The list is currently empty'**
  String get the_list_is_currently_empty;

  /// No description provided for @oops_You_re_offline_check_your_connection_and_give_it_another_shot.
  ///
  /// In en, this message translates to:
  /// **'Oops! You\'re offline. Check your connection and give it another shot.'**
  String get oops_You_re_offline_check_your_connection_and_give_it_another_shot;

  /// No description provided for @something_went_wrong_tap_to_try_again.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Tap to try again.'**
  String get something_went_wrong_tap_to_try_again;

  /// No description provided for @please_try_again_later.
  ///
  /// In en, this message translates to:
  /// **'Please try again later.'**
  String get please_try_again_later;

  /// No description provided for @otpIsRequired.
  ///
  /// In en, this message translates to:
  /// **'OTP is required'**
  String get otpIsRequired;

  /// No description provided for @otpMustBe6Digits.
  ///
  /// In en, this message translates to:
  /// **'OTP must be 6 digits'**
  String get otpMustBe6Digits;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is Required'**
  String get emailIsRequired;

  /// No description provided for @enterAValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterAValidEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @passwordMustBeAtLeastCharacters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBeAtLeastCharacters;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get confirmPasswordIsRequired;

  /// No description provided for @enterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get enterYourConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Password does not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @user_onboarding_one.
  ///
  /// In en, this message translates to:
  /// **'Search and browse youth Sport events near you — tryouts, camps, and tournaments. Filter by sport, age, and location to quickly discover the right events.'**
  String get user_onboarding_one;

  /// No description provided for @user_onboarding_two.
  ///
  /// In en, this message translates to:
  /// **'Tap any event to see full information, including date, venue, age group, and skill level.'**
  String get user_onboarding_two;

  /// No description provided for @user_onboarding_three.
  ///
  /// In en, this message translates to:
  /// **'Register directly through the organizer’s external link. All registrations and payments are handled by the organizer, giving you full control.'**
  String get user_onboarding_three;

  /// No description provided for @management_onboarding_one.
  ///
  /// In en, this message translates to:
  /// **'Start by adding essential details for your event — name, date, location, age group, and a short description. This helps families quickly understand what your event offers.'**
  String get management_onboarding_one;

  /// No description provided for @management_onboarding_two.
  ///
  /// In en, this message translates to:
  /// **'“Provide the external registration link (e.g., your webpage or social media link) where families can sign up and pay. You remain in full control of registrations and payments.'**
  String get management_onboarding_two;

  /// No description provided for @management_onboarding_three.
  ///
  /// In en, this message translates to:
  /// **'Once submitted, your event is published on the platform and visible to families searching for activities. You can add more events anytime, all for free.'**
  String get management_onboarding_three;

  /// No description provided for @user_onboarding_title_one.
  ///
  /// In en, this message translates to:
  /// **'Find Events'**
  String get user_onboarding_title_one;

  /// No description provided for @user_onboarding_title_two.
  ///
  /// In en, this message translates to:
  /// **'Explore Event Details'**
  String get user_onboarding_title_two;

  /// No description provided for @user_onboarding_title_three.
  ///
  /// In en, this message translates to:
  /// **'Register with Ease'**
  String get user_onboarding_title_three;

  /// No description provided for @management_onboarding_title_one.
  ///
  /// In en, this message translates to:
  /// **'List Your First Event'**
  String get management_onboarding_title_one;

  /// No description provided for @management_onboarding_title_two.
  ///
  /// In en, this message translates to:
  /// **'Add Registration Link'**
  String get management_onboarding_title_two;

  /// No description provided for @management_onboarding_title_three.
  ///
  /// In en, this message translates to:
  /// **'Go Live & Reach Families'**
  String get management_onboarding_title_three;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @welcomeToPlayFinderUSA.
  ///
  /// In en, this message translates to:
  /// **'Welcome to PlayFinderUSA'**
  String get welcomeToPlayFinderUSA;

  /// No description provided for @remember_me.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get remember_me;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dont_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get log_in;

  /// No description provided for @choose_your_role.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Role'**
  String get choose_your_role;

  /// No description provided for @discover_register_events.
  ///
  /// In en, this message translates to:
  /// **'Discover and register for youth Sport events — or list and manage your own. PlayFinderUSA has the right tools for you.'**
  String get discover_register_events;

  /// No description provided for @find_events.
  ///
  /// In en, this message translates to:
  /// **'Find Events'**
  String get find_events;

  /// No description provided for @list_events.
  ///
  /// In en, this message translates to:
  /// **'List Events'**
  String get list_events;

  /// No description provided for @continues.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continues;

  /// No description provided for @create_your_account.
  ///
  /// In en, this message translates to:
  /// **'Create Your Account'**
  String get create_your_account;

  /// No description provided for @join_for_free.
  ///
  /// In en, this message translates to:
  /// **'Join for free to find, browse, and register for youth Sport events near you, all in one place.'**
  String get join_for_free;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @email_address.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email_address;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirm_password;

  /// No description provided for @agree_terms_privacy.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms & Conditions and Privacy Policy.'**
  String get agree_terms_privacy;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @verify_your_email.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verify_your_email;

  /// No description provided for @verify_email_description.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a verification code to this Email to confirm your account.'**
  String get verify_email_description;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @send_otp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get send_otp;

  /// No description provided for @six_digit_code.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get six_digit_code;

  /// No description provided for @enter_verification_code.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code we\'ve sent to your Email.'**
  String get enter_verification_code;

  /// No description provided for @did_not_receive_code.
  ///
  /// In en, this message translates to:
  /// **'Did’t receive the code?'**
  String get did_not_receive_code;

  /// No description provided for @resend_otp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resend_otp;

  /// No description provided for @set_new_password.
  ///
  /// In en, this message translates to:
  /// **'Set Your New Password'**
  String get set_new_password;

  /// No description provided for @create_secure_password.
  ///
  /// In en, this message translates to:
  /// **'Create a secure password to protect your account and get started seamlessly!'**
  String get create_secure_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New password'**
  String get confirm_new_password;

  /// No description provided for @log_in_to_your_account_to_find.
  ///
  /// In en, this message translates to:
  /// **'Log in to your account to find events or manage your listings.'**
  String get log_in_to_your_account_to_find;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameIsRequired;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @donTHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get donTHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @forgotPasswordOnly.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPasswordOnly;

  /// No description provided for @pleaseEnterYourEmailToResetThePassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to reset the password'**
  String get pleaseEnterYourEmailToResetThePassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterThe6DigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code that was in the email'**
  String get enterThe6DigitCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCode;

  /// No description provided for @haveNotGotTheEmailYet.
  ///
  /// In en, this message translates to:
  /// **'Haven’t got the email yet?'**
  String get haveNotGotTheEmailYet;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendEmail;

  /// No description provided for @setANewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get setANewPassword;

  /// No description provided for @createANewPasswordEnsureTtDiffersFrom.
  ///
  /// In en, this message translates to:
  /// **'Create a new password. Ensure it differs from previous ones for security'**
  String get createANewPasswordEnsureTtDiffersFrom;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @fieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @are_you_sure_you_want_delete_account.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want delete account?'**
  String get are_you_sure_you_want_delete_account;

  /// No description provided for @i_agree_to_the.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get i_agree_to_the;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @shortlisted.
  ///
  /// In en, this message translates to:
  /// **'Shortlisted'**
  String get shortlisted;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @add_event.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get add_event;

  /// No description provided for @my_event.
  ///
  /// In en, this message translates to:
  /// **'My Events'**
  String get my_event;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @areYouSureYouWantToLogOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogOut;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help/Support'**
  String get helpSupport;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password:'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password:'**
  String get newPassword;

  /// No description provided for @repeatPassword.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password:'**
  String get repeatPassword;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @mySubscription.
  ///
  /// In en, this message translates to:
  /// **'My Subscription'**
  String get mySubscription;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @our_help_line_service_is_active.
  ///
  /// In en, this message translates to:
  /// **'Our help line service is active: 24/7'**
  String get our_help_line_service_is_active;

  /// No description provided for @mailUs.
  ///
  /// In en, this message translates to:
  /// **'Mail Us ({email})'**
  String mailUs(Object email);

  /// No description provided for @lastPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Last Purchase Date'**
  String get lastPurchaseDate;

  /// No description provided for @subscriptionExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Subscription Expiry Date'**
  String get subscriptionExpiryDate;

  /// No description provided for @renewSubscription.
  ///
  /// In en, this message translates to:
  /// **'Renew Subscription'**
  String get renewSubscription;

  /// No description provided for @location_ZIP_Code_or_City.
  ///
  /// In en, this message translates to:
  /// **'Location (ZIP Code or City)'**
  String get location_ZIP_Code_or_City;

  /// No description provided for @selectOne.
  ///
  /// In en, this message translates to:
  /// **'Select One'**
  String get selectOne;

  /// No description provided for @ageGroup.
  ///
  /// In en, this message translates to:
  /// **'Age Group'**
  String get ageGroup;

  /// No description provided for @skillLevel.
  ///
  /// In en, this message translates to:
  /// **'Skill Level'**
  String get skillLevel;

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'Date Range'**
  String get dateRange;

  /// No description provided for @apply_filter.
  ///
  /// In en, this message translates to:
  /// **'Apply Filter'**
  String get apply_filter;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @no_categories_found.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get no_categories_found;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @sportCategories.
  ///
  /// In en, this message translates to:
  /// **'Sport Categories'**
  String get sportCategories;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @featuredEvents.
  ///
  /// In en, this message translates to:
  /// **'Featured Events'**
  String get featuredEvents;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @aboutTheEvent.
  ///
  /// In en, this message translates to:
  /// **'About The Event'**
  String get aboutTheEvent;

  /// No description provided for @registration_deadline.
  ///
  /// In en, this message translates to:
  /// **'Registration Deadline'**
  String get registration_deadline;

  /// No description provided for @ages.
  ///
  /// In en, this message translates to:
  /// **'Ages'**
  String get ages;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @available_slot.
  ///
  /// In en, this message translates to:
  /// **'Available Slot'**
  String get available_slot;

  /// No description provided for @eventType.
  ///
  /// In en, this message translates to:
  /// **'Event Type'**
  String get eventType;

  /// No description provided for @eventStartOn.
  ///
  /// In en, this message translates to:
  /// **'Event Start On'**
  String get eventStartOn;

  /// No description provided for @startsForm.
  ///
  /// In en, this message translates to:
  /// **'Starts Form'**
  String get startsForm;

  /// No description provided for @goToEventRegistrationLink.
  ///
  /// In en, this message translates to:
  /// **'Go to Event Registration Link'**
  String get goToEventRegistrationLink;

  /// No description provided for @organizer_info.
  ///
  /// In en, this message translates to:
  /// **'Organizer info'**
  String get organizer_info;

  /// No description provided for @organizedBy.
  ///
  /// In en, this message translates to:
  /// **'Organized By'**
  String get organizedBy;

  /// No description provided for @ratings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get ratings;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact Email'**
  String get contactEmail;

  /// No description provided for @contactPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact Phone'**
  String get contactPhone;

  /// No description provided for @eventLocation.
  ///
  /// In en, this message translates to:
  /// **'Event Location'**
  String get eventLocation;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @my_shortlisted_event.
  ///
  /// In en, this message translates to:
  /// **'My Shortlisted Event'**
  String get my_shortlisted_event;

  /// No description provided for @registrationOpen.
  ///
  /// In en, this message translates to:
  /// **'Registration Open'**
  String get registrationOpen;

  /// No description provided for @eventStarted.
  ///
  /// In en, this message translates to:
  /// **'Event Started'**
  String get eventStarted;

  /// No description provided for @eventFinished.
  ///
  /// In en, this message translates to:
  /// **'Event Finished'**
  String get eventFinished;

  /// No description provided for @eventBasics.
  ///
  /// In en, this message translates to:
  /// **'Event Basics'**
  String get eventBasics;

  /// No description provided for @eventPhotos.
  ///
  /// In en, this message translates to:
  /// **'Event Photos'**
  String get eventPhotos;

  /// No description provided for @uploadImages.
  ///
  /// In en, this message translates to:
  /// **'Upload Images'**
  String get uploadImages;

  /// No description provided for @eventName.
  ///
  /// In en, this message translates to:
  /// **'Event Name'**
  String get eventName;

  /// No description provided for @eventShortDescription.
  ///
  /// In en, this message translates to:
  /// **'Event Short Description'**
  String get eventShortDescription;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @eventDatesRegistration.
  ///
  /// In en, this message translates to:
  /// **'Event Dates & Registration'**
  String get eventDatesRegistration;

  /// No description provided for @registrationStartDate.
  ///
  /// In en, this message translates to:
  /// **'Registration Start Date'**
  String get registrationStartDate;

  /// No description provided for @registrationEndTime.
  ///
  /// In en, this message translates to:
  /// **'Registration End Time'**
  String get registrationEndTime;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @registrationEndDate.
  ///
  /// In en, this message translates to:
  /// **'Registration End Date'**
  String get registrationEndDate;

  /// No description provided for @eventStartDate.
  ///
  /// In en, this message translates to:
  /// **'Event Start Date'**
  String get eventStartDate;

  /// No description provided for @eventStartTime.
  ///
  /// In en, this message translates to:
  /// **'Event Start Time'**
  String get eventStartTime;

  /// No description provided for @eventEndDate.
  ///
  /// In en, this message translates to:
  /// **'Event End Date'**
  String get eventEndDate;

  /// No description provided for @eventEndTime.
  ///
  /// In en, this message translates to:
  /// **'Event End Time'**
  String get eventEndTime;

  /// No description provided for @participantsLocation.
  ///
  /// In en, this message translates to:
  /// **'Participants & Location'**
  String get participantsLocation;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **'Zip Code'**
  String get zipCode;

  /// No description provided for @locationNameVenue.
  ///
  /// In en, this message translates to:
  /// **'Location Name / Venue'**
  String get locationNameVenue;

  /// No description provided for @cityState.
  ///
  /// In en, this message translates to:
  /// **'City / State'**
  String get cityState;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @registrationEventDetails.
  ///
  /// In en, this message translates to:
  /// **'Registration & Event Details'**
  String get registrationEventDetails;

  /// No description provided for @eventWebsiteRegistrationLink.
  ///
  /// In en, this message translates to:
  /// **'Event Website/Registration Link'**
  String get eventWebsiteRegistrationLink;

  /// No description provided for @eventRegistrationFee.
  ///
  /// In en, this message translates to:
  /// **'Event Registration Fee'**
  String get eventRegistrationFee;

  /// No description provided for @describeAboutYourEvent.
  ///
  /// In en, this message translates to:
  /// **'Describe About Your Event'**
  String get describeAboutYourEvent;

  /// No description provided for @savePublish.
  ///
  /// In en, this message translates to:
  /// **'Save & Publish'**
  String get savePublish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
