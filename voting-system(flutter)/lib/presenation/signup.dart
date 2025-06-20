import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true; // Toggle between Sign-In & Sign-Up
  bool isVoter = true; // Toggle between Voter & Organizer
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  bool _isLoading = false;

  void _toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _authenticate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulating login/signup process
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isLogin
                ? (isVoter ? "Voter Logged in successfully!" : "Organizer Logged in successfully!")
                : (isVoter ? "Voter Account created successfully!" : "Organizer Account created successfully!")),
          ),
        );

        // Redirect based on selection
        if (isLogin) {
          Navigator.pushReplacementNamed(context, isVoter ? "/voter_dashboard" : "/organizer_dashboard");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.how_to_vote, size: 100, color: Colors.blue),
                SizedBox(height: 20),
                Text(
                  isLogin ? "Sign In" : "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]),
                ),
                SizedBox(height: 30),

                // Toggle between Voter & Organizer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVoter = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isVoter ? Colors.green : Colors.grey,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Voter"),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isVoter = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isVoter ? Colors.grey : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("Organizer"),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Form for Sign-In & Sign-Up
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!isLogin) ...[
                        // Full Name Field
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.person, color: Colors.blueGrey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your full name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains("@")) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      if (!isLogin) ...[
                        // Phone Number Field
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            prefixIcon: Icon(Icons.phone, color: Colors.blueGrey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 10) {
                              return "Enter a valid phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      if (!isLogin) ...[
                        // Confirm Password Field
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.blueGrey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],

                      if (!isLogin && !isVoter) ...[
                        // Organization Name Field (Only for Organizers)
                        TextFormField(
                          controller: _organizationController,
                          decoration: InputDecoration(
                            labelText: "Organization Name",
                            prefixIcon: Icon(Icons.business, color: Colors.blueGrey),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your organization name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                      ],

                      // Submit Button
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _authenticate,
                              child: Text(isLogin ? "Sign In" : "Create Account"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),

                      // Bottom Sign-in Button
                      TextButton(
                        onPressed: _toggleAuthMode,
                        child: Text(
                          isLogin ? "Don't have an account? Sign Up" : "Already have an account? Sign In",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
