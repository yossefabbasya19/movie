import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/feature/on_boarding/data/model/on_boarding_DM.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (value) {
            currentPage = value;
            setState(() {});
          },
          children:
              onBoardingItems.map((onBoardingPage) {
                return Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Image(
                      width: width,
                      image: AssetImage(onBoardingPage.imagePath),
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                onBoardingPage.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 8),
                              Text(
                                onBoardingPage.description ?? '',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(height: height * 0.02),
                              SizedBox(
                                height: height * 0.06,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorsManager.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (currentPage !=
                                        onBoardingItems.length - 1) {
                                      pageController.nextPage(
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.easeIn,
                                      );
                                    } else {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        MyRoutes.register,
                                      );
                                    }
                                  },
                                  child: Text(
                                    currentPage == onBoardingItems.length - 1
                                        ? "Finish"
                                        : "Next",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              currentPage != 0
                                  ? SizedBox(
                                    height: height * 0.06,
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: ColorsManager.yellow,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: ColorsManager.yellow,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        pageController.previousPage(
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.linear,
                                        );
                                      },
                                      child: Text(
                                        "Back",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium!.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
