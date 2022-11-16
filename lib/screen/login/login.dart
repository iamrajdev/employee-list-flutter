import 'package:employee_info/model/login_response_model.dart';
import 'package:employee_info/provider/auth_provider.dart';
import 'package:employee_info/screen/resources/assets_manager.dart';
import 'package:employee_info/screen/resources/colors.dart';
import 'package:employee_info/screen/resources/route_manager.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool hidePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (String? value) {
        if (value!.trim().isEmpty) {
          return AppStrings.fieldRequired;
        } else if (!value.contains('@')) {
          return AppStrings.invalidEmail;
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white30,
        prefixIcon: const Icon(Icons.mail_outline, color: Colors.white),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: AppStrings.enterYourEmail,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
      ),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: hidePassword,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return AppStrings.fieldRequired;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white30,
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
        suffixIcon: IconButton(
          icon: Icon(
            hidePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white.withOpacity(0.7),
          ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: AppStrings.yourPassword,
        hintStyle: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: const Text(
          AppStrings.logIn,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColor.btnBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          submit();
        },
      ),
    );

    final circularLoading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        CircularProgressIndicator(),
      ],
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.grad1Color,
                  AppColor.grad2Color,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 14.0, 36.0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Image(
                    image: AssetImage(ImageAssets.splashLogo),
                    height: 150,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const Text(
                              AppStrings.logIn,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppStrings.email,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            emailField,
                            const SizedBox(height: 15),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppStrings.password,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            passwordField,
                            if (errorMessage.isNotEmpty)
                              const SizedBox(height: 15),
                            Text(
                              errorMessage,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            auth.isAuthenticated
                                ? circularLoading
                                : loginButton,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    final form = _formKey.currentState;
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    if (!form!.validate()) {
      return;
    }

    if (form.validate()) {
      form.save();

      Future<List<LoginResponseModel>?> responseData =
          auth.login(emailController.text, passwordController.text);
      responseData.then((response) {
        if (response!.isNotEmpty) {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        } else {
          auth.isAuthenticated = false;
          setState(() {
            errorMessage = AppStrings.invalidEmailPassword;
          });
        }
      });
    } else {
      setState(() {
        errorMessage = AppStrings.invalidCredential;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
