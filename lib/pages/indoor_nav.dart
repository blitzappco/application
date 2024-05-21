import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Step {
  final String imageUrl;
  final String instruction;
  final String additionalText;

  Step(this.imageUrl, this.instruction, this.additionalText);
}

class IndoorNavPage extends StatefulWidget {
  // Sample mock steps with image URLs, instructions, and additional text
  final List<Step> mockSteps = [
    Step(
        'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
        'Head towards the information left.',
        'Look for the large blue sign.'),
    Step(
        'https://images.unsplash.com/photo-1716093264767-7d818c805f7c?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'Take the escalator down',
        'The escalator is next to the coffee shop.'),
    Step(
        'https://images.unsplash.com/photo-1716182716887-a285a8466308?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'Follow signs for the blue line.',
        'The blue line is towards the back of the station.'),
  ];

  IndoorNavPage({Key? key}) : super(key: key);

  @override
  State<IndoorNavPage> createState() => _MyNavigationStepsState();
}

class _MyNavigationStepsState extends State<IndoorNavPage> {
  final _pageController = PageController();
  final _instructionsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _instructionsScrollController.addListener(() {
      double page = _instructionsScrollController.offset /
          MediaQuery.of(context).size.width;
      if (_pageController.page != page.round()) {
        _pageController.jumpToPage(page.round());
      }
    });
  }

  @override
  void dispose() {
    _instructionsScrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.mockSteps.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: widget.mockSteps[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => IndoorNavPage()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.black,
                                size: 25,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: PageScrollPhysics(),
                    controller: _instructionsScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.mockSteps
                          .map((step) => Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Ensure full width
                                child: StepInstruction(
                                  instruction: step.instruction,
                                  additionalText: step.additionalText,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepInstruction extends StatelessWidget {
  final String instruction;
  final String additionalText;

  const StepInstruction({
    Key? key,
    required this.instruction,
    required this.additionalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.directions,
                    size: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instruction,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: "UberMoveBold"),
                    ),
                    Text(
                      additionalText,
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: "UberMoveMedium"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
