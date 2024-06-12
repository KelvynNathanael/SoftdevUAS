import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator LoginScreen - FRAME
    return Container(
        width: 360,
        height: 800,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-1, 3.078285231087447e-15),
              end: Alignment(-1.4043778736905514e-15, -4.938271999359131),
              colors: [
                Color.fromRGBO(119, 18, 18, 1),
                Color.fromRGBO(49, 12, 12, 1)
              ]),
        ),
        child: Stack(children: <Widget>[
          Positioned(top: 1, left: -5, child: Container()),
          Positioned(
              top: 529,
              left: 270,
              child: Text(
                'Lupa password?',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    letterSpacing: -0.30000001192092896,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    decoration: TextDecoration.none),
              )),
          Positioned(
              top: 397,
              left: 50,
              child: Container(
                  width: 337,
                  height: 49,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 17,
                        left: 19,
                        child: Text(
                          'Email',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(245, 245, 245, 1),
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              letterSpacing: -0.30000001192092896,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 337,
                            height: 49,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                                bottomLeft: Radius.circular(45),
                                bottomRight: Radius.circular(45),
                              ),
                              border: Border.all(
                                color: Color.fromRGBO(245, 245, 245, 1),
                                width: 3,
                              ),
                            ))),
                  ]))),
          Positioned(
              top: 569,
              left: 50,
              child: Container(
                  width: 337,
                  height: 49,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 337,
                            height: 49,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                                bottomLeft: Radius.circular(45),
                                bottomRight: Radius.circular(45),
                              ),
                              color: Color.fromRGBO(18, 18, 18, 1),
                              border: Border.all(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                width: 3,
                              ),
                            ))),
                    Positioned(
                        top: 17,
                        left: 146,
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(245, 245, 245, 1),
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              letterSpacing: -0.30000001192092896,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                  ]))),
          Positioned(
              top: 470,
              left: 50,
              child: Container(
                  width: 337,
                  height: 49,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 17,
                        left: 19,
                        child: Text(
                          'Password',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(245, 245, 245, 1),
                              fontFamily: 'Montserrat',
                              fontSize: 15,
                              letterSpacing: -0.30000001192092896,
                              fontWeight: FontWeight.normal,
                              height: 1,
                              decoration: TextDecoration.none),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 337,
                            height: 49,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                                bottomLeft: Radius.circular(45),
                                bottomRight: Radius.circular(45),
                              ),
                              border: Border.all(
                                color: Color.fromRGBO(245, 245, 245, 1),
                                width: 3,
                              ),
                            ))),
                    Positioned(
                        top: 18,
                        left: 302,
                        child: Container(
                            width: 21,
                            height: 14,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/eye.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                  ]))),
          Positioned(
              top: 801,
              left: 100,
              child: Text(
                'Belum punya akun? Daftar sekarang',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    letterSpacing: -0.30000001192092896,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    decoration: TextDecoration.none),
              )),
          Positioned(
              top: 639,
              left: 182,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Sansation',
                      fontSize: 15,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1,
                      decoration: TextDecoration.none),
                ),
              )),
          Positioned(
              top: 94,
              left: 125,
              child: Container(
                  width: 167,
                  height: 216,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fitWidth),
                  ))),
        ]));
  }
}