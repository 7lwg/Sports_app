import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app_semicolon/Functions/showDialog.dart';
import 'package:sport_app_semicolon/Screens/LeagueScreen.dart';
import 'package:sport_app_semicolon/Screens/CountriesScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.black),
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                    // color: Colors.red,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    FootballCountriesView(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/football.png",
                                  ),
                                  fit: BoxFit.fill),
                            ),
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Football",
                            style: GoogleFonts.lato(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showMyDialog(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/cricket.png",
                                  ),
                                  fit: BoxFit.fill),
                            ),
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                          GestureDetector(
                            onTap: () {
                              showMyDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Cricket",
                                style: GoogleFonts.lato(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showMyDialog(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.5,
                      // color: Colors.red,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/basketball.png",
                                  ),
                                  fit: BoxFit.fill),
                            ),
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Basketball",
                              style: GoogleFonts.lato(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showMyDialog(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/tennis.png",
                                  ),
                                  fit: BoxFit.fill),
                            ),
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: MediaQuery.of(context).size.height * 0.45,
                            // child: Image.asset(
                            //   'assets/images/football.png',
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Tennis",
                              style: GoogleFonts.lato(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
