import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app_semicolon/Cubits/SliderCubit/slider_cubit.dart';
import 'package:sport_app_semicolon/Screens/LoginScreen.dart';
import 'HomeScreen.dart';
import 'test.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

final List<String> title = [
  "Select Your Country",
  "Discover Exciting Leagues",
  "Team Profiles",
  "Player Profiles"
];

final List<String> subtitle = [
  "- Choose your favorite football nation to explore leagues, teams, and players.",
  "- Explore top football leagues from around the world and stay updated with the latest scores and standings.",
  "- Get to know your favorite teams, their histories, squad details, and recent performances.",
  "- Dive into the world of football stars. Learn about their careers, achievements, and stats."
];

final List<String> Illustration = [
  "- Flags of various countries representing different football nations.",
  "- Logos of prominent football leagues (e.g., Premier League, La Liga, Serie A).",
  "- Logos of popular football clubs or a team jersey.",
  "- Portraits or action shots of iconic football players."
];

final CarouselController _controller1 = CarouselController();

int active_page = 0;

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BlocBuilder<SliderCubit, SliderState>(
          builder: (context, state) {
            return CarouselSlider(
                items: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[850],
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                title[i].toString(),
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 10,
                            ),
                            Text(
                              subtitle[i].toString(),
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                Illustration[i].toString(),
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
                carouselController: _controller1,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) => {
                    active_page = index,
                    context.read<SliderCubit>().Slider(),
                  },
                  scrollDirection: Axis.horizontal,
                ));
          },
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Skip'),
                ),
              ),
              BlocBuilder<SliderCubit, SliderState>(
                builder: (context, state) {
                  return AnimatedSmoothIndicator(
                    activeIndex: active_page,
                    count: 4,
                    onDotClicked: (index) => {
                      active_page = index,
                      _controller1.animateToPage(active_page),
                      context.read<SliderCubit>().button(),
                    },
                  );
                },
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
