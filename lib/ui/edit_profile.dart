import 'package:flutter/material.dart';
import 'package:mobile/ui/onboarding_screen.dart';

void main() {
  runApp(editProfile());
}

class editProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator editProfile - FRAME
    return Container(
      width: 360,
      height: 800,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1, 3.078285231087447e-15),
          end: Alignment(-1.4043778736905514e-15, -4.938271999359131),
          colors: [
            Color.fromRGBO(119, 18, 18, 1),
            Color.fromRGBO(49, 12, 12, 1),
          ],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 100,
            left: 120,
            child: Container(
              width: 200,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/Profile1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Positioned(
            top: 320,
            left: 190,
            child: Text(
              'Blauza',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Sansation',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Positioned(
            top: 56,
            left: 25,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/icon_arrow_left.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 51,
            left: 330,
            child: Container(
              width: 83,
              height: 41.856231689453125,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 83,
                      height: 41,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Color.fromRGBO(18, 18, 18, 1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 25.5,
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Sansation',
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 685,
            left: 50,
            child: Container(
              width: 337,
              height: 49,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 337,
                      height: 49,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: Color.fromRGBO(18, 18, 18, 1),
                        border: Border.all(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 49),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OnBoardingScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(
                        fontFamily: "AB",
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
