import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_or.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('en'),
    Locale('or')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Konark Learn'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get changeLanguage;

  /// Personalized greeting on the home page
  ///
  /// In en, this message translates to:
  /// **'Good {timeOfDay}, {userName}!'**
  String greetingUser(String timeOfDay, String userName);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get goodEvening;

  /// No description provided for @homeWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What would you like to learn today?'**
  String get homeWelcomeSubtitle;

  /// No description provided for @todaysChallenge.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Challenge'**
  String get todaysChallenge;

  /// No description provided for @todaysChallengeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try the \'Math Quiz\' in the Games section!'**
  String get todaysChallengeSubtitle;

  /// No description provided for @letsGetLearning.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get learning'**
  String get letsGetLearning;

  /// No description provided for @lessons.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get lessons;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @aiHelper.
  ///
  /// In en, this message translates to:
  /// **'AI Helper'**
  String get aiHelper;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @exploreAllSubjects.
  ///
  /// In en, this message translates to:
  /// **'Explore All Subjects'**
  String get exploreAllSubjects;

  /// No description provided for @myProgress.
  ///
  /// In en, this message translates to:
  /// **'My Progress'**
  String get myProgress;

  /// No description provided for @courseCompletion.
  ///
  /// In en, this message translates to:
  /// **'Course Completion'**
  String get courseCompletion;

  /// No description provided for @currentCourse.
  ///
  /// In en, this message translates to:
  /// **'Current Course'**
  String get currentCourse;

  /// No description provided for @nextLesson.
  ///
  /// In en, this message translates to:
  /// **'Next Lesson'**
  String get nextLesson;

  /// No description provided for @sustainableFarming.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Farming Practices'**
  String get sustainableFarming;

  /// No description provided for @cropRotation.
  ///
  /// In en, this message translates to:
  /// **'Crop Rotation Techniques'**
  String get cropRotation;

  /// No description provided for @availableCourses.
  ///
  /// In en, this message translates to:
  /// **'Available Courses'**
  String get availableCourses;

  /// No description provided for @organicAgriculture.
  ///
  /// In en, this message translates to:
  /// **'Organic Agriculture'**
  String get organicAgriculture;

  /// No description provided for @livestockManagement.
  ///
  /// In en, this message translates to:
  /// **'Livestock Management'**
  String get livestockManagement;

  /// No description provided for @agriBusiness.
  ///
  /// In en, this message translates to:
  /// **'Agri-Business Basics'**
  String get agriBusiness;

  /// No description provided for @communityForum.
  ///
  /// In en, this message translates to:
  /// **'Community Forum'**
  String get communityForum;

  /// No description provided for @forumDiscussion.
  ///
  /// In en, this message translates to:
  /// **'Discussion: Pest Control Tips'**
  String get forumDiscussion;

  /// No description provided for @forumNewPost.
  ///
  /// In en, this message translates to:
  /// **'New Post: Share Your Harvest!'**
  String get forumNewPost;

  /// No description provided for @learningResources.
  ///
  /// In en, this message translates to:
  /// **'Learning Resources'**
  String get learningResources;

  /// No description provided for @videoTutorials.
  ///
  /// In en, this message translates to:
  /// **'Video Tutorials'**
  String get videoTutorials;

  /// No description provided for @downloadableGuides.
  ///
  /// In en, this message translates to:
  /// **'Downloadable Guides'**
  String get downloadableGuides;

  /// No description provided for @expertQA.
  ///
  /// In en, this message translates to:
  /// **'Expert Q&A'**
  String get expertQA;

  /// No description provided for @calendarEvents.
  ///
  /// In en, this message translates to:
  /// **'Calendar & Events'**
  String get calendarEvents;

  /// No description provided for @workshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get workshop;

  /// No description provided for @fieldTrip.
  ///
  /// In en, this message translates to:
  /// **'Field Trip'**
  String get fieldTrip;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @subjects.
  ///
  /// In en, this message translates to:
  /// **'Subjects'**
  String get subjects;

  /// No description provided for @educationalGames.
  ///
  /// In en, this message translates to:
  /// **'Educational Games'**
  String get educationalGames;

  /// No description provided for @mathQuiz.
  ///
  /// In en, this message translates to:
  /// **'Math Quiz'**
  String get mathQuiz;

  /// No description provided for @wordPuzzle.
  ///
  /// In en, this message translates to:
  /// **'Word Puzzle'**
  String get wordPuzzle;

  /// No description provided for @memoryMatch.
  ///
  /// In en, this message translates to:
  /// **'Memory Match'**
  String get memoryMatch;

  /// No description provided for @geographyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Geography Challenge'**
  String get geographyChallenge;

  /// No description provided for @testArithmetic.
  ///
  /// In en, this message translates to:
  /// **'Test your arithmetic and problem-solving skills.'**
  String get testArithmetic;

  /// No description provided for @findHiddenWords.
  ///
  /// In en, this message translates to:
  /// **'Find the hidden words and expand your vocabulary.'**
  String get findHiddenWords;

  /// No description provided for @improveMemory.
  ///
  /// In en, this message translates to:
  /// **'Improve your memory by matching pairs.'**
  String get improveMemory;

  /// No description provided for @knowWorld.
  ///
  /// In en, this message translates to:
  /// **'How well do you know the world? Find out now!'**
  String get knowWorld;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'is coming soon!'**
  String get comingSoon;

  /// No description provided for @quizDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Quiz downloaded successfully!'**
  String get quizDownloaded;

  /// No description provided for @downloadingQuiz.
  ///
  /// In en, this message translates to:
  /// **'Generating and downloading quiz...'**
  String get downloadingQuiz;

  /// No description provided for @failedDownload.
  ///
  /// In en, this message translates to:
  /// **'Failed to download quiz: '**
  String get failedDownload;

  /// No description provided for @topics.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get topics;

  /// No description provided for @noTopics.
  ///
  /// In en, this message translates to:
  /// **'No topics found for this subject.'**
  String get noTopics;

  /// No description provided for @menuBook.
  ///
  /// In en, this message translates to:
  /// **'Menu Book'**
  String get menuBook;

  /// No description provided for @memoryMatchDesc.
  ///
  /// In en, this message translates to:
  /// **'Improve your memory by matching pairs.'**
  String get memoryMatchDesc;

  /// No description provided for @wordPuzzleDesc.
  ///
  /// In en, this message translates to:
  /// **'Arrange letters to form words.'**
  String get wordPuzzleDesc;

  /// No description provided for @quizGame.
  ///
  /// In en, this message translates to:
  /// **'Quiz Game'**
  String get quizGame;

  /// No description provided for @quizGameDesc.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge with quizzes.'**
  String get quizGameDesc;

  /// No description provided for @flashcardGame.
  ///
  /// In en, this message translates to:
  /// **'Flashcard Game'**
  String get flashcardGame;

  /// No description provided for @flashcardGameDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn with flashcards.'**
  String get flashcardGameDesc;

  /// No description provided for @topicMatching.
  ///
  /// In en, this message translates to:
  /// **'Topic Matching'**
  String get topicMatching;

  /// No description provided for @topicMatchingDesc.
  ///
  /// In en, this message translates to:
  /// **'Match topics with their descriptions.'**
  String get topicMatchingDesc;

  /// No description provided for @mathMonsterBattleDesc.
  ///
  /// In en, this message translates to:
  /// **'Battle monsters with math questions.'**
  String get mathMonsterBattleDesc;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @playLearnAchieve.
  ///
  /// In en, this message translates to:
  /// **'Play Learn Achieve More'**
  String get playLearnAchieve;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registrationFailed;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email already in use'**
  String get emailAlreadyInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Weak password'**
  String get weakPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @chatWithAI.
  ///
  /// In en, this message translates to:
  /// **'Chat with AI'**
  String get chatWithAI;

  /// No description provided for @mickeyAIHelper.
  ///
  /// In en, this message translates to:
  /// **'Mickey Your AI Helper'**
  String get mickeyAIHelper;

  /// No description provided for @askMickey.
  ///
  /// In en, this message translates to:
  /// **'Ask Mickey anything!'**
  String get askMickey;

  /// No description provided for @mickeyWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hi there, future genius! I\'m Mickey, your friendly AI Helper. What exciting things do you want to learn about today?'**
  String get mickeyWelcome;

  /// No description provided for @apiKeyError.
  ///
  /// In en, this message translates to:
  /// **'Oops! My AI brain isn\'t connected. Please check your API Key!'**
  String get apiKeyError;

  /// No description provided for @didNotCatch.
  ///
  /// In en, this message translates to:
  /// **'I didn\'t quite catch that. Could you please rephrase?'**
  String get didNotCatch;

  /// No description provided for @somethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong: '**
  String get somethingWrong;

  /// No description provided for @mickey.
  ///
  /// In en, this message translates to:
  /// **'Mickey'**
  String get mickey;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeMessage;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @myTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get myTasks;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitle;

  /// No description provided for @taskDescription.
  ///
  /// In en, this message translates to:
  /// **'Task Description'**
  String get taskDescription;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @myAchievements.
  ///
  /// In en, this message translates to:
  /// **'My Achievements'**
  String get myAchievements;

  /// No description provided for @completedLessons.
  ///
  /// In en, this message translates to:
  /// **'Completed Lessons'**
  String get completedLessons;

  /// No description provided for @completedQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Completed Quizzes'**
  String get completedQuizzes;

  /// No description provided for @earnedPoints.
  ///
  /// In en, this message translates to:
  /// **'Earned Points'**
  String get earnedPoints;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @offlineLessons.
  ///
  /// In en, this message translates to:
  /// **'Offline Lessons'**
  String get offlineLessons;

  /// No description provided for @offlineQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Offline Quizzes'**
  String get offlineQuizzes;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @generatingLesson.
  ///
  /// In en, this message translates to:
  /// **'Generating lesson...'**
  String get generatingLesson;

  /// No description provided for @lessonGenerated.
  ///
  /// In en, this message translates to:
  /// **'Lesson generated successfully!'**
  String get lessonGenerated;

  /// No description provided for @failedGenerateLesson.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate lesson: '**
  String get failedGenerateLesson;

  /// No description provided for @quizLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading Quiz...'**
  String get quizLoading;

  /// No description provided for @startQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz'**
  String get startQuiz;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect!'**
  String get incorrect;

  /// No description provided for @yourScore.
  ///
  /// In en, this message translates to:
  /// **'Your Score: '**
  String get yourScore;

  /// No description provided for @mathMonsterBattle.
  ///
  /// In en, this message translates to:
  /// **'Math Monster Battle'**
  String get mathMonsterBattle;

  /// No description provided for @levelAddition.
  ///
  /// In en, this message translates to:
  /// **'Level 1: Addition'**
  String get levelAddition;

  /// No description provided for @levelFractions.
  ///
  /// In en, this message translates to:
  /// **'Level 2: Fractions'**
  String get levelFractions;

  /// No description provided for @levelMixed.
  ///
  /// In en, this message translates to:
  /// **'Level 3: Mixed Problems'**
  String get levelMixed;

  /// No description provided for @defeatedMonsters.
  ///
  /// In en, this message translates to:
  /// **'You defeated all monsters!'**
  String get defeatedMonsters;

  /// No description provided for @greatJob.
  ///
  /// In en, this message translates to:
  /// **'Great job, Math Hero!'**
  String get greatJob;
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
      <String>['en', 'or'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'or':
      return AppLocalizationsOr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
