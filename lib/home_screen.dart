import 'package:busha_task/custom_drawer.dart';
import 'package:busha_task/widgets/amount_view.dart';
import 'package:busha_task/widgets/exchange_rate_view.dart';
import 'package:busha_task/widgets/options_buttons.dart';
import 'package:busha_task/widgets/transaction_view.dart';
import 'package:busha_task/widgets/user_name_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static final GlobalKey appBarAvatarKey = GlobalKey();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _openDrawer(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) =>
          CustomDrawerScreen(appBarAvatarKey: HomeScreen.appBarAvatarKey),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onHorizontalDragStart: (details) {
              if (details.globalPosition.dx < 100) {
                _openDrawer(context);
              }
            },
            child: Column(
              children: [
                UserNameView(onTap: () => _openDrawer(context)),
                Expanded(
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: size.height * 0.08),
                            AmountView(),
                            SizedBox(height: 30),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(4, (index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: index < 3 ? 8.0 : 0),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: index == 0
                                                ? Colors.green
                                                : Colors.grey.shade300,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 20),
                            OptionButton(),
                            SizedBox(height: 30),
                            TransactionView(),
                            SizedBox(height: 30),
                            ExchangeRateView(),
                            SizedBox(height: 50),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
