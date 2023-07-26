import 'package:flutter/material.dart';

class Dispose extends StatelessWidget {
  final Widget statutBar;
  final Widget mainContent;
  final Widget sideOne;
  final Widget sideTwo;
  final Widget sideTree;
  const Dispose(
      {super.key,
      required this.statutBar,
      required this.mainContent,
      required this.sideOne,
      required this.sideTwo,
      required this.sideTree});

  @override
  Widget build(BuildContext context) {
    late final double screenWidth = MediaQuery.of(context).size.width;
    late final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 0.95 * screenHeight,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 0.60 * screenWidth,
                height: 0.9 * screenHeight,
                color: Theme.of(context).primaryColor,
                child: mainContent,
              ),
              SizedBox(
                width: 0.35 * screenWidth,
                height: 0.90 * screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 0.40 * screenHeight,
                      width: 0.35 * screenWidth,
                      color: Theme.of(context).primaryColor,
                      child: sideOne,
                    ),
                    Container(
                      height: 0.4 * screenHeight,
                      width: 0.35 * screenWidth,
                      color: Theme.of(context).primaryColor,
                      child: sideTwo,
                    ),
                    Container(
                      height: 0.05 * screenHeight,
                      width: 0.35 * screenWidth,
                      color: Theme.of(context).primaryColor,
                      child: sideTree,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          height: 0.05 * screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: const Border(top: BorderSide())),
          child: statutBar,
        )
      ],
    );
  }
}
