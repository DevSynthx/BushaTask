import 'package:busha_task/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Options> options = Options.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int index = 0; index < options.length; index++) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                  color: (options[index] != Options.send)
                      ? Colors.grey.shade200
                      : Colors.black,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    options[index].icons,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                        (options[index] != Options.send)
                            ? Colors.black
                            : Colors.white,
                        BlendMode.srcIn),
                  ),
                  if (options[index] != Options.more)
                    Text(
                      options[index].message,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: (options[index] != Options.send)
                              ? Colors.black
                              : Colors.white),
                    )
                ],
              ),
            ),
            if (index < options.length - 1) SizedBox(width: 10),
          ]
        ],
      ),
    );
  }
}

enum Options {
  send("Send", AppImage.arrowUp),
  convert("Convert", AppImage.arrowLeftRight),
  add("Add", AppImage.plus),
  more("...", AppImage.dotsHorizontal);

  const Options(this.message, this.icons);
  final String message;
  final String icons;
}
