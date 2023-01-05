import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/provider/user_provider.dart';
import '/responsive/responsive_layout_screen.dart';
import '/responsive/mobile_screen_layout.dart';
import '/responsive/web_screen_layout.dart';
import '/router_generator.dart';
import '/screens/login_screen.dart';
import '/utils/color.dart';
import '/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCnSpd6K2F8ySCL1FBZeIyL0EdCS0HRevg',
        appId: '1:187718807276:web:a5366765653f946bb4bfc9',
        messagingSenderId: '187718807276',
        projectId: 'instagram-clone-d9606',
        storageBucket: "instagram-clone-d9606.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayoutScreen(
                  weblayout: WebScreenLayout(),
                  mobilelayout: MobileScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginScreen();
          },
        ),
        initialRoute: InitialRouteName,
        onGenerateRoute: RouterGenerator.generateRoute,
      ),
    );
  }
}
