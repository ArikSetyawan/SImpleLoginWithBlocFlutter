import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/Blocs/AuthUserBloc/auth_user_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthUserBloc, AuthUserState>(
        listener: (context, state) {
          if (state is AuthUserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthUserLogin){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Logged In, Wellcome")));
          }
        },
        child: SafeArea(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login Page", style: TextStyle(fontSize: 48)),
                  const SizedBox(
                    height: 24,
                  ),
                  // Email TextBox
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                    validator: (value) {
                      if (value != null && EmailValidator.validate(value)) {
                        return null;
                      } else {
                        return "Please enter a valid email";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Password TextBox
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? "Please Enter Some Text"
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<AuthUserBloc, AuthUserState>(
                      builder: (context, state) {
                        if (state is AuthUserSignInLoading){
                          return const ElevatedButton(
                            onPressed: null, 
                            child: Center(child: CircularProgressIndicator())
                          );
                        } else{
                          return ElevatedButton(
                            onPressed: () {
                              final isvalid = _formKey.currentState!.validate();
                              if (isvalid) {
                                context.read<AuthUserBloc>().add(SignInEvent(
                                    _emailController.text,
                                    _passwordController.text));
                              }
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            )
                          );
                        }
                      },
                    ),
                  )
                ],
              )),
        ))),
      ),
    );
  }
}
