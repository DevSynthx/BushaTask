import 'package:busha_task/components/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExchangeRateView extends StatelessWidget {
  const ExchangeRateView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ExchangeRate> exchangeRate = ExchangeRate.values;
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
                "Exchange rates",
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
            shrinkWrap: true,
            itemCount: exchangeRate.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: Row(
                  spacing: 8,
                  children: [
                    SvgPicture.asset(
                      exchangeRate[index].icons,
                      height: 20,
                    ),
                    Text(
                      exchangeRate[index].message,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}

enum ExchangeRate {
  send("1 GBP = 2,300 NGN", AppImage.ukFlag),
  convert("1 USD = 1,500 NGN", AppImage.america),
  add("1 Yen = 10.34 NGN", AppImage.china),
  ghana("1 Cedis = 145.34 NGN", AppImage.ghana);

  const ExchangeRate(this.message, this.icons);
  final String message;
  final String icons;
}
