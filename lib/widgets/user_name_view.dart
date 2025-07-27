import 'package:busha_task/home_screen.dart';
import 'package:flutter/material.dart';

class UserNameView extends StatelessWidget {
  const UserNameView({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: onTap,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Hero(
                  tag: "avatar",
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    key: HomeScreen.appBarAvatarKey,
                    child: Text(
                      "JD",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: Text(
              "EARN 10k",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
