import 'package:busha_task/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AmountView extends StatelessWidget {
  const AmountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            CircleAvatar(
              radius: 10,
              child: SvgPicture.asset(AppImage.ukFlag),
            ),
            Text(
              "GBP Balance",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        SizedBox(height: 5),
        Text(
          "GBP 67",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            "Accounts",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
