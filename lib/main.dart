import 'package:barcode/home_page.dart';
import 'package:barcode/home_login.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode/app_state.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

// Add GoRouter configuration outside the App class
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeLogin(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null
                  };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  // if (!user.emailVerified) {
                  //   user.sendEmailVerification();
                  //   const snackBar = SnackBar(
                  //       content: Text(
                  //           'Please check your email to verify your email address'));
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // }
                  context.pushReplacement('/');
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'homepage',
          builder: (context, state) => const HomePage(),
          // path: 'profile',
          // builder: (context, state) {
          // return
          // ProfileScreen(
          //   providers: const [],
          //   actions: [
          //     SignedOutAction((context) {
          //       context.pushReplacement('/');
          //     }),
          //   ],
          // );
          // },
        ),
      ],
    ),
  ],
);
// end of GoRouter configuration

// Change MaterialApp to MaterialApp.router and add the routerConfig

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.    gg
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Safebite',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.deepPurple,
            ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      // routes: {
      //   "/principale": (context) => const HomeScreen(),
      // },
      debugShowCheckedModeBanner: false,
      // initialRoute: "/principale",
      routerConfig: _router,
      // home: const HomePage(),
    );
  }
}
