import 'package:ezfastnow/src/pages/find_ezfastnow_screen.dart';
import 'package:ezfastnow/src/pages/home_screen.dart';
import 'package:ezfastnow/src/pages/save_weight.dart';
import 'package:ezfastnow/src/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'src/models/route_argument.dart';
import 'src/pages/all_fasts_screen.dart';
import 'src/pages/all_weights_list_screen.dart';
import 'src/pages/all_weights_screen.dart';
import 'src/pages/contact_support.dart';
import 'src/pages/dark_mode_screen.dart';
import 'src/pages/edit_profile.dart';
import 'src/pages/email_screen.dart';
import 'src/pages/forgot_password.dart';
import 'src/pages/login.dart';
import 'src/pages/my_data_screen.dart';
import 'src/pages/my_profile_screen.dart';
import 'src/pages/notifications_screen.dart';
import 'src/pages/reminder_screen.dart';
import 'src/pages/signup.dart';
import 'src/pages/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/ForgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPasswordWidget());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/Reminder':
        return MaterialPageRoute(builder: (_) => ReminderScreen());
      case '/FindEzFast':
        return MaterialPageRoute(builder: (_) => FindEzFastWidget());
      case '/MyData':
        return MaterialPageRoute(builder: (_) => MyDataWidget());
      case '/MyProfile':
        return MaterialPageRoute(builder: (_) => MyProfileWidget());
      case '/EditProfile':
        return MaterialPageRoute(builder: (_) => EditProfileWidget());
      case '/SaveWeight':
        return MaterialPageRoute(builder: (_) => SaveWeightWidget());
      case '/EmailWidget':
        return MaterialPageRoute(builder: (_) => EmailWidget());
      case '/Notification':
        return MaterialPageRoute(builder: (_) => NotificationWidget());
      case '/DarkMode':
        return MaterialPageRoute(builder: (_) => DarkModeWidget());
      case '/Chat':
        return MaterialPageRoute(builder: (_) => ChatWidget());
      case '/AllFastsHours':
        return MaterialPageRoute(builder: (_) => AllFastsHoursWidget());
      case '/AllWeights':
        return MaterialPageRoute(builder: (_) => AllWeightsWidget());
        case '/AllWeightsList':
        return MaterialPageRoute(builder: (_) => AllWeightsListWidget());
      // return MaterialPageRoute(builder: (_) => ChatWidget(routeArgument: args as RouteArgument));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: SizedBox(height: 0)));
    }
  }
}
