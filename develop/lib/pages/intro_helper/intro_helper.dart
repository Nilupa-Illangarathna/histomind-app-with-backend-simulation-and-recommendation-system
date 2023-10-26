import 'package:flutter/material.dart';
import '/widgets/matelCirculerImageContainer/metel_circuler_image_container.dart';
import '/widgets/gradientButton/gradient_button.dart';
import '/pages/home.dart';
import '/widgets/lenceFlare/lence_flare.dart';
import '/DartFilesForPages/intro_helper_data/data.dart';

class IntroHelper extends StatefulWidget {


  const IntroHelper();
  @override
  _IntroHelperState createState() => _IntroHelperState();
}

class _IntroHelperState extends State<IntroHelper> {
  List<SliderModel> mySLides = [];
  int slideIndex = 0;
  late PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  void nextSlide() {
    controller.animateToPage(slideIndex + 1,
        duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  void skipSlides() {
    controller.animateToPage(3,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height - 100,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: <Widget>[
                SlideTile(
                  imagePath: mySLides[0].getImageAssetPath(),
                  title: mySLides[0].getTitle(),
                  desc: mySLides[0].getDesc(),
                ),
                SlideTile(
                  imagePath: mySLides[1].getImageAssetPath(),
                  title: mySLides[1].getTitle(),
                  desc: mySLides[1].getDesc(),
                ),
                SlideTile(
                  imagePath: mySLides[2].getImageAssetPath(),
                  title: mySLides[2].getTitle(),
                  desc: mySLides[2].getDesc(),
                ),
                SlideTile(
                  imagePath: mySLides[3].getImageAssetPath(),
                  title: mySLides[3].getTitle(),
                  desc: mySLides[3].getDesc(),
                )
              ],
            ),
          ),
          bottomSheet: slideIndex != 3
              ? Container(
                  color: Colors.black,
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(
                        width: 0,
                      ),
                      GradientButton(
                        width: 100,
                        height: 50,
                        onClick: skipSlides,
                        buttonText: "SKIP",
                      ),
                      Container(
                        child: Row(
                          children: [
                            for (int i = 0; i < 4; i++)
                              i == slideIndex
                                  ? _buildPageIndicator(true)
                                  : _buildPageIndicator(false),
                          ],
                        ),
                      ),
                      GradientButton(
                        width: 100,
                        height: 50,
                        onClick: nextSlide,
                        buttonText: "Next",
                      ),
                      SizedBox(
                        width: 0,
                      ),
                    ],
                  ),
                )
              : Container(
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientButton(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 50,
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(), // Navigate to the NewScreen widget
                            ),
                          );
                        },
                        buttonText: "Get Started",
                      ),
                    ],
                  ),
                )),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({required this.imagePath, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * (1 / 8),
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.width * (5 / 7),
                  width: MediaQuery.of(context).size.width * (5 / 7),
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.007),
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.0, 1.0],
                          colors: [Colors.white, Colors.black])),
                  child: Container(
                    width: MediaQuery.of(context).size.width * (5 / 7),
                    height: MediaQuery.of(context).size.width * (5 / 7),
                    child: MetalEdgesContainer(
                      imageUrl: imagePath,
                      width: MediaQuery.of(context).size.width * (5 / 7),
                      elevation: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * (3 / 4),
                    child: Text(desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13)),
                  )
                ],
              ),
            ],
          ),
        ),
        LensFlareContainer(
          diameter: 200.0, // Specify the diameter
          color: Color(0xFF4D1F3E), // Specify the color
          x: MediaQuery.of(context).size.width * 1 / 6, // X-coordinate
          y: MediaQuery.of(context).size.height * 1 / 6, // Y-coordinate
          opacity: 1.0,
        ),
        LensFlareContainer(
          diameter: 200.0, // Specify the diameter
          color: Color(0xFF08594C), // Specify the color
          x: MediaQuery.of(context).size.width * 5 / 6, // X-coordinate
          y: MediaQuery.of(context).size.height * 3 / 12, // Y-coordinate
          opacity: 1.0,
        ),
      ],
    );
  }
}
