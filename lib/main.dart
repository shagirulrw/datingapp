import 'package:datingapp/provider/cardprovider.dart';
import 'package:datingapp/provider/user_provider.dart';

import 'package:datingapp/screens/homepage.dart';
import 'package:flutter/services.dart';
import 'package:datingapp/screens/signin.dart';
// import 'package:datingapp/screens/updatesecondarydetails.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

// void initialization() async {
//   // This is where you can initialize the resources needed by your app while
//   // the splash screen is displayed.  Remove the following example because
//   // delaying the user experience is a bad design practice!
//   // ignore_for_file: avoid_print
//   print('ready in 3...');
//   await Future.delayed(const Duration(seconds: 1));
//   print('ready in 2...');
//   await Future.delayed(const Duration(seconds: 1));
//   print('ready in 1...');
//   await Future.delayed(const Duration(seconds: 1));
//   print('go!');
//   FlutterNativeSplash.remove();
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CardProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: ScreenUtilInit(
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'DATTIN',
              home: Scaffold(
                body: child,
              ),
            );
          },
          designSize: const Size(390, 844),
          child: const Authwrapper(),
          // child: const UpdateSecondaryDetails(),
        )
        // const MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   title: 'DATING APP',
        //   home: Scaffold(
        //     body: Authwrapper(),
        //   ),
        // ),
        );
    // const MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: Scaffold(
    //     body: SignInScreen(),
    //   ),
    // );
  }
}

class Authwrapper extends StatefulWidget {
  const Authwrapper({Key? key}) : super(key: key);

  @override
  State<Authwrapper> createState() => _AuthwrapperState();
}

class _AuthwrapperState extends State<Authwrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  // addData() async {
  //   UserProvider user_provider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   await user_provider.refrehUser();
  // }
  addData() async {
    context.read<UserProvider>().refrehUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // String naame =
            // int age = context.read<UserProvider>().getuser.age;
            // // print("updated");
            // return age == 0 ? AddDetails() : HomePage();
            // MatchScreen();
            return const HomePage();
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
        return const SignInScreen();
      },
    );
  }

  @override
  void dispose() {
    // Never called
    // print("Disposing first route");
    super.dispose();
  }
}
