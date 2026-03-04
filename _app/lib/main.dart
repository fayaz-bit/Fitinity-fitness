import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// Models
import 'package:_app/models/admin_model.dart';
import 'package:_app/models/usermodel.dart';
import 'package:_app/models/vedio_model.dart';
import 'package:_app/models/meal_model.dart';
import 'package:_app/models/mealdetail_model.dart';
import 'models/dailygoal_model.dart';

// Screens
import 'onboarding_screens/app_flow/screens/splash_screen.dart';
import 'home/home_page/home_section/screens/home_screen.dart';
import 'authentication/screens/enter_phone_screen.dart';
import 'authentication/screens/login_screen.dart';
import 'authentication/screens/sign_up_screen.dart';
import 'onboarding_screens/app_flow/screens/First_screen.dart';
import 'onboarding_screens/app_flow/screens/second_screen.dart';
import 'onboarding_screens/app_flow/screens/third_screen.dart';
import 'onboarding_screens/user_info/screens/gender_selection_screen.dart';
import 'onboarding_screens/user_info/screens/height_selection_screen.dart';
import 'onboarding_screens/user_info/screens/wieght_selection_screen.dart';
import 'onboarding_screens/user_info/screens/age_selection_screen.dart';
import 'onboarding_screens/goals/screens/fitness_goal_screen.dart';
import 'onboarding_screens/goals/screens/fitness_level_screen.dart';
import 'home/profile_details/profile/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // ✅ Register all adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AdminWorkoutCategoryAdapter());
  Hive.registerAdapter(AdminVideoModelAdapter());
  Hive.registerAdapter(MealCategoryAdapter());
  Hive.registerAdapter(MealFieldModelAdapter());
  Hive.registerAdapter(DailyWorkoutAdapter());

  // ✅ Open all boxes
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<AdminWorkoutCategory>('admin_workouts');
  await Hive.openBox<AdminVideoModel>('admin_video_settings');
  await Hive.openBox<MealCategory>('meal_categories');
  await Hive.openBox<MealFieldModel>('meal_fields');
  await Hive.openBox<DailyWorkout>('daily_workouts');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/splash', // start at splash screen
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/second': (context) => const SecondPage(),
        '/third': (context) => const ThirdPage(),

        // Personal info screens
        '/gender': (context) => const GenderSelectionScreen(),
        '/height': (context) => HeightSelection(gender: ''),
        '/weight': (context) => const WeightSelection(gender: '', height: ''),
        '/age': (context) =>
            const AgeSelectionScreen(gender: '', height: '', weight: ''),
        '/fitnessGoal': (context) => const FitnessGoalScreen(
            gender: '', height: '', weight: '', age: ''),
        '/fitnessLevel': (context) => const FitnessLevelScreen(
            gender: '', height: '', weight: '', age: ''),

        // Login/signup
        '/enterPhone': (context) => const EnterPhoneScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) =>
            const SignUpScreen(gender: '', height: '', weight: '', age: ''),

        // Main app
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
