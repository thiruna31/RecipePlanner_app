import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final void Function(bool loggedIn) onAuthComplete;
  const AuthScreen({super.key, required this.onAuthComplete});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = true;
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  String? error;

  void _switchForm() {
    setState(() {
      showLogin = !showLogin;
      error = null;
    });
  }

  void _tryAuth() {
    if (!showLogin && nameCtrl.text.trim().isEmpty) {
      setState(() => error = "Full name is required");
      return;
    }
    if (emailCtrl.text.trim().isEmpty ||
        passwordCtrl.text.length < 5) {
      setState(() => error = "Email and password (min 5 chars) required.");
    } else {
      widget.onAuthComplete(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey[900]!]
                : [Colors.teal[400]!, Colors.green[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              elevation: 14,
              color: isDark ? Colors.grey[900] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.restaurant_menu_rounded,
                      size: 48,
                      color: isDark ? Colors.tealAccent : Colors.teal,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      showLogin ? "Welcome Back" : "Create Your Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.teal[900],
                      ),
                    ),
                    const SizedBox(height: 26),
                    if (!showLogin)
                      TextField(
                        controller: nameCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    if (!showLogin) const SizedBox(height: 18),
                    TextField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: passwordCtrl,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 20),
                      Text(error!, style: const TextStyle(color: Colors.red)),
                    ],
                    const SizedBox(height: 28),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _tryAuth,
                      child: Text(
                        showLogin ? "Sign In" : "Sign Up",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextButton(
                      onPressed: _switchForm,
                      style: TextButton.styleFrom(
                        foregroundColor:
                            isDark ? Colors.tealAccent : Colors.teal,
                      ),
                      child: Text(
                        showLogin
                            ? "Don't have an account? Sign Up"
                            : "Already have an account? Sign In",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
