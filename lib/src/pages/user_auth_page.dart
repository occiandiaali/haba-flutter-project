import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/authentication/bloc/app_auth_bloc.dart';
import '../utils/secure_local_storage.dart';
import 'home_page.dart';

class UserAuthPage extends StatefulWidget {
  const UserAuthPage({Key? key}) : super(key: key);

  @override
  State<UserAuthPage> createState() => _UserAuthPageState();
}

class _UserAuthPageState extends State<UserAuthPage> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool hideExtraFields = false;
  String existingUsername = "";

  @override
  void dispose() {
     _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    returnStoredUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppAuthBloc, AppAuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AppAuthBloc, AppAuthState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),
                );
              }
              if (state is UnAuthenticated) {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.deepOrangeAccent,
                              child: Image.asset(
                                "assets/images/haba_orange.jpg",
                                height: 80,
                                width: 80,
                              ),
                            ),
                            const SizedBox(height: 18,),
                            Text(
                              hideExtraFields ? "Create a new account" : "Welcome back",
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'Cera Pro',
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 18,),
                            Center(
                              child: Form(
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: hideExtraFields || existingUsername.isEmpty || existingUsername == "",
                                      child: TextFormField(
                                        controller: _usernameCtrl,
                                        decoration: const InputDecoration(
                                          labelText: "Username",
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.deepOrange),
                                          ),
                                        ),
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          String res = '';
                                          if (value!.isEmpty || value == "") {
                                            res = 'You need a username!';
                                          }
                                          return res;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: hideExtraFields || existingUsername.isEmpty || existingUsername == "" ? 12 : 0),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailCtrl,
                                      decoration: const InputDecoration(
                                        labelText: "Email",
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.deepOrange),
                                        ),
                                      ),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        return value != null &&
                                            !EmailValidator.validate(value) ?
                                        "Enter a valid email address" : null;
                                      },
                                    ),
                                    const SizedBox(height: 12,),
                                    TextFormField(
                                      keyboardType: TextInputType.visiblePassword,
                                      controller: _passCtrl,
                                      obscureText: hidePassword,
                                      obscuringCharacter: '=',
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            padding: const EdgeInsetsDirectional.only(end: 12.0),
                                            onPressed: () {
                                              if (hidePassword == true) {
                                                setState(() {
                                                  hidePassword = false;
                                                });
                                              } else {
                                                setState(() {
                                                  hidePassword = true;
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              hidePassword ?
                                              Icons.visibility_off_rounded : Icons.visibility,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          hintText: "Password",
                                          border: const OutlineInputBorder()
                                      ),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        return value != null &&
                                            value.length < 6 ?
                                        "Enter minimum of 6 characters" : null;
                                      },
                                    ),
                                     SizedBox(height: hideExtraFields ? 12 : 0),
                                     Visibility(
                                       visible: hideExtraFields,
                                       child: TextFormField(
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: hideConfirmPassword,
                                        obscuringCharacter: '=',
                                         decoration: InputDecoration(
                                             suffixIcon: IconButton(
                                               padding: const EdgeInsetsDirectional.only(end: 12.0),
                                               onPressed: () {
                                                 if (hideConfirmPassword == true) {
                                                   setState(() {
                                                     hideConfirmPassword = false;
                                                   });
                                                 } else {
                                                   setState(() {
                                                     hideConfirmPassword = true;
                                                   });
                                                 }
                                               },
                                               icon: Icon(
                                                 hideConfirmPassword ?
                                                 Icons.visibility_off_rounded : Icons.visibility,
                                                 color: Colors.teal,
                                               ),
                                             ),
                                             hintText: "Confirm Password",
                                             border: const OutlineInputBorder()
                                         ),
                                         autovalidateMode:
                                         AutovalidateMode.onUserInteraction,
                                        validator: (String? value) {
                                          String res = '';
                                          if (value!.isEmpty || value != _passCtrl.text) {
                                            res = 'Passwords must match!';
                                          }
                                          return res;
                                        },
                                    ),
                                     ),
                                    const SizedBox(height: 16,),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.5,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          !hideExtraFields ? _signInToAccount(context) : _signUpForAccount(context);
                                        },
                                        child: Text(!hideExtraFields ? "Sign In" : "Sign Up"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12,),
                            Text(hideExtraFields ? "Already have an account?" : "No account yet?"),
                            OutlinedButton(
                                onPressed: () {
                                  _toggleHiddenFields();
                                },
                                child: Text(hideExtraFields ? "Sign In" : "Sign Up"))
                          ],
                        ),
                      ),
                    )
                );
              }
              return Container();
            },
          )
      ),
    );
  }
  //
  void _toggleHiddenFields() {
    if (hideExtraFields == true) {
      setState(() {
        hideExtraFields = false;
      });
    } else {
      setState(() {
        hideExtraFields = true;
      });
    }
  }

  Future<void> storeUserName() async {
    final StorageItem username = StorageItem('username', _usernameCtrl.text);
    SecureLocalStorage().writeSecureData(username);
  }

  Future<void> returnStoredUsername() async {
    Future<String> futureStr = Future.value(await SecureLocalStorage().readSecureData('username'));
    String res = await futureStr;
    setState(() {
      existingUsername = res;
    });
  }

  void _signUpForAccount(context) {
      storeUserName();
      BlocProvider.of<AppAuthBloc>(context).add(
        SignUpRequested(_emailCtrl.text, _passCtrl.text),
      );
  }

  // void _signInToAccount(context) {
  //     BlocProvider.of<AppAuthBloc>(context).add(
  //       SignInRequested(_emailCtrl.text, _passCtrl.text),
  //     );
  // }

  void _signInToAccount(context) {
    if (existingUsername.isNotEmpty || existingUsername != "") {
      BlocProvider.of<AppAuthBloc>(context).add(
        SignInRequested(_emailCtrl.text, _passCtrl.text),
      );
    } else {
      storeUserName();
      BlocProvider.of<AppAuthBloc>(context).add(
        SignInRequested(_emailCtrl.text, _passCtrl.text),
      );
    }
  }
  // end of state class
}
