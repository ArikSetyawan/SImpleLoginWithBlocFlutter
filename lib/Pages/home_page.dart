import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/Blocs/AuthUserBloc/auth_user_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("HomePage", style: TextStyle(fontSize: 48),),
                const SizedBox(height: 16,),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthUserBloc>().add(SignOutEvent());
                    }, 
                    child: const Text("Logout")
                  ),
                )
              ],
            ),
          ),
          
        )
      ),
    );
  }
}