import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_bloc/Blocs/AuthUserBloc/auth_user_bloc.dart';
import 'package:login_bloc/Pages/authcheckloading_page.dart';
import 'package:login_bloc/Pages/home_page.dart';
import 'package:login_bloc/Pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
        routes: [
          GoRoute(
            path: "/login",
            name: "login",
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
            path: "/",
            name: "home",
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: "/authcheck",
            name: "authcheck",
            builder: (context, state) => const AuthCheckLoadingPage(),
          ),
        ],
        initialLocation: "/login",
        debugLogDiagnostics: true,
        routerNeglect: true);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthUserBloc()..add(CheckSignInStatusEvent()),
        )
      ],
      child: BlocListener<AuthUserBloc, AuthUserState>(
        listener: (context, state) {
          if (state is AuthUserLogin) {
            router.goNamed("home");
          } else if (state is AuthUserLoading) {
            router.goNamed("authcheck");
          } else {
            router.goNamed("login");
          }
        },
        child: MaterialApp.router(
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          routerDelegate: router.routerDelegate,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
