import 'package:flutter/material.dart';

class OurText extends StatelessWidget {
  final String label;
  const OurText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w900,
        //fontFamily: 'Lilli'
      ),
    );
  }
}

Widget getImageWidget(String category) {
  switch (category) {
    case 'overcast clouds':
      return Image.asset('assets/tl2.png');
    case 'clear sky':
      return Image.asset('assets/sun.png');
    case 'haze':
      return Image.asset('assets/winter.png');
    case 'few clouds':
      return Image.asset('assets/d.webp');
    case 'broken clouds':
      return Image.asset('assets/d.webp');
    case 'moderate rain':
      return Image.asset('assets/d.webp');
    default:
      return Image.asset('assets/s2.webp');
  }
}
