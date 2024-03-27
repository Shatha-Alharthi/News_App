import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetLastNew extends StatelessWidget {
  const WidgetLastNew({
    Key? key,
    required this.text1,
    required this.text2,
    required this.image,
    required this.opacity,
    required this.fun,
  }) : super(key: key);

  final String text1;
  final String text2;
  final String image;
  final double opacity;
  final Function() fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        fun();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Opacity(
              opacity: opacity,
              child: Image.network(
                image,
                width: 321,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              right: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: const TextStyle(
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          text2,
                          style: const TextStyle(
                            fontFamily: 'NunitoSans',
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
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
