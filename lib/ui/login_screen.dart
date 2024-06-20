import 'package:flutter/material.dart';
import 'package:mobile/globals.dart'; // Import GlobalPlayerState
import 'package:mobile/ui/dashboard_screen.dart'; // Import DashboardScreen

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(119, 18, 18, 1), // Dark red
              Color.fromRGBO(49, 12, 12, 1), // Darker red
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 1,
              left: -5,
              child: Container(),
            ),
            Positioned(
              top: 569,
              left: 50,
              child: Container(
                width: 337,
                height: 49,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          String inputEmail = emailController.text;
                          String inputPassword = passwordController.text;

                          if (inputEmail == GlobalPlayerState.email &&
                              inputPassword == GlobalPlayerState.password) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashBoardScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid email or password'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 337,
                          height: 49,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            color: Color.fromRGBO(51, 0, 0, 1),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromRGBO(250, 250, 250, 1),
                                fontFamily: 'ABeeZee',
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1.25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 305,
              left: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 14,
                      color: Color.fromRGBO(250, 250, 250, 1),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 337,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                    ),
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Password',
                    style: TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 14,
                      color: Color.fromRGBO(250, 250, 250, 1),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 337,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromRGBO(255, 255, 255, 0.1),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
