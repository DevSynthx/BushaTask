import 'package:busha_task/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                spreadRadius: 10,
                blurRadius: 20,
                color: Colors.grey.shade100,
                offset: Offset(0, 0.3))
          ]),
      child: Column(
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Transactions",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  spacing: 14,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: SvgPicture.asset(AppImage.arrowLeftRight),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 3,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            spacing: 6,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "GBP",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SvgPicture.asset(
                                AppImage.arrowRight,
                                height: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "NGN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                              Text(
                                "50 GBP",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              )
                            ],
                          ),
                          Row(
                            spacing: 6,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Converted",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.5),
                              ),
                              Text(
                                ".",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.5),
                              ),
                              Expanded(
                                child: Text(
                                  "Yesterday",
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.5),
                                ),
                              ),
                              Text(
                                "110,862 NGN",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.5),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                    height: 35,
                  ))
        ],
      ),
    );
  }
}
