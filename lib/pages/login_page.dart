import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  // Declare the form key inside the state class
  final GlobalKey<FormState> _loginformkey = GlobalKey<FormState>();

  String? username;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SafeArea(
          child: _buildUI()), // Call _buildUI function inside the state class
    );
  }

  // _buildUI function inside the state class
  Widget _buildUI() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _title(),
        _loginForm(), // Pass the form key here
      ],
    );
  }

  // Other functions are also inside the state class
  Widget _title() {
    return const Text(
      "Recipe Book",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Form(
            key: _loginformkey, // Use the passed form key here
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: "emilys",
                    onSaved: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "enter a username";
                      }
                    },
                    decoration: const InputDecoration(hintText: "Username"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    initialValue: "emilyspass",
                    onSaved: (value) {
                      setState(() {
                        pass = value;
                      });
                    },
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return "enter a valid password";
                      }
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                ),
                _loginbutton()
              ],
            )),
      ),
    );
  }

  Widget _loginbutton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: () async {
            if (_loginformkey.currentState?.validate() ?? false) {
              _loginformkey.currentState?.save();
              bool result = await AuthService().login(username!, pass!);

              if (result) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                _showErrorDialog("Login Failed");
              }
            }
          },
          child: const Text("Login")),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Failed"),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
