import 'package:attendance_uni_app/models/student.dart';
import 'package:attendance_uni_app/provider/attendance.dart';
import 'package:attendance_uni_app/provider/new_students.dart';
import 'package:attendance_uni_app/provider/repeater_students.dart';
import 'package:attendance_uni_app/provider/subjects.dart';
import 'package:attendance_uni_app/screens/add_students.dart';
import 'package:attendance_uni_app/screens/add_subject.dart';
import 'package:attendance_uni_app/screens/attendance_sheet.dart';

import 'package:attendance_uni_app/screens/home_screen.dart';
import 'package:attendance_uni_app/screens/login_screen.dart';
import 'package:attendance_uni_app/screens/repeaters_attendance_sheet.dart';
import 'package:attendance_uni_app/screens/show_data.dart';

import 'package:attendance_uni_app/screens/show_stored_data.dart';
import 'package:attendance_uni_app/screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/screens/splash_screen.dart';
import '/utilities/routes.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Subjects()),
        ChangeNotifierProvider(create: (_) => Students()),
        ChangeNotifierProvider(
            create: (_) => Student(name: '', rollNo: '', id: '')),
        ChangeNotifierProvider(create: (_) => RepStudents()),
        ChangeNotifierProvider(create: (_) => Attendance()),
        // ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.libreBaskervilleTextTheme(
              // Theme.of(context).textTheme,

              ),
          backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
          cardColor: const Color.fromRGBO(4, 174, 175, 1),
          hintColor: const Color.fromRGBO(13, 118, 170, 1),
          primaryColor: const Color.fromRGBO(9, 119, 103, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: const ColorScheme.light(
              secondary: Color.fromRGBO(255, 255, 255, 1)),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
            titleTextStyle: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // fontFamily: ,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        initialRoute: MyRoutes.splashScreenRoute,
        routes: {
          MyRoutes.splashScreenRoute: (context) => const MySplashScreen(),
          MyRoutes.loginScreenRoute: (context) => const Login(),
          MyRoutes.signUpScreenRoute: (context) => const SignupScreen(),
          MyRoutes.homeScreenRoute: (context) => const HomeScreen(),
          MyRoutes.addSubjectScreenRoute: (context) => const AddSubject(),
          MyRoutes.addStudentScreenRoute: (context) => const AddStudent(),
          MyRoutes.attendanceScreenRoute: (context) => const AttendanceSheet(
                subjName: '',
              ),
          MyRoutes.showDataScreenRoute: (context) => const ShowData(),
          MyRoutes.showStoreDataScreenRoute: (context) => const ShowStored(
                subjName: '',
                date: '',
              ),
          MyRoutes.repAttendanceScreenRoute: (context) =>
              const RepeaterAttendanceSheet(
                subjName: '',
              ),
          // MyRoutes.repShowDataScreenRoute: (context) => const RepShowStored(
          //       subjName: '',
          //     ),
        },
      ),
    );
  }
}
