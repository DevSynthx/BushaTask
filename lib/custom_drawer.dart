import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDrawerScreen extends StatefulWidget {
  final GlobalKey appBarAvatarKey;

  const CustomDrawerScreen({super.key, required this.appBarAvatarKey});

  @override
  State<CustomDrawerScreen> createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen>
    with SingleTickerProviderStateMixin {
  // final double drawerWidth = 250;
  // double offsetX = 250;

  late double drawerWidth;
  late double offsetX;
  bool initialized = false;

  bool showSimulatedAvatar = true;

  final GlobalKey _drawerAvatarKey = GlobalKey();

  Offset drawerAvatarPosition = Offset.zero;
  Offset appBarAvatarPosition = Offset.zero;

  void _getAvatarPositions() {
    final RenderBox? drawerBox =
        _drawerAvatarKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? appBarBox =
        widget.appBarAvatarKey.currentContext?.findRenderObject() as RenderBox?;

    if (drawerBox != null && appBarBox != null) {
      drawerAvatarPosition = drawerBox.localToGlobal(Offset.zero);
      appBarAvatarPosition = appBarBox.localToGlobal(Offset.zero);
    }

    // log('Drawer avatar position: $drawerAvatarPosition');
    // log('AppBar avatar position: $appBarAvatarPosition');
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    _getAvatarPositions();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      offsetX += details.delta.dx;
      offsetX = offsetX.clamp(0, drawerWidth);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (offsetX > drawerWidth / 2) {
      setState(() => offsetX = drawerWidth);
    } else {
      setState(() => offsetX = 0);
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.of(context).pop();
      });
    }
  }

  void _animateClose() {
    final duration = const Duration(milliseconds: 300);
    final start = offsetX;
    final end = 0.0;
    final controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    final animation = Tween<double>(begin: start, end: end).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.addListener(() {
      setState(() {
        offsetX = animation.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
        Navigator.of(context).pop();
      }
    });

    controller.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      drawerWidth = MediaQuery.of(context).size.width;
      offsetX = drawerWidth;
      initialized = true;
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _getAvatarPositions());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ProfileOptions> profileInfo = ProfileOptions.values;
    if (!initialized) return const SizedBox.shrink();

    final double progress = offsetX / drawerWidth;
    final Offset avatarPos = Offset.lerp(
          drawerAvatarPosition,
          appBarAvatarPosition,
          1 - progress,
        ) ??
        Offset.zero;
    final double size = lerpDouble(70, 40, 1 - progress)!;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(progress * 0.1),
      body: GestureDetector(
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Stack(
          children: [
            // Drawer Panel
            Transform.translate(
              offset: Offset(offsetX - drawerWidth, 0),
              child: Container(
                width: drawerWidth,
                height: double.infinity,
                color: const Color.fromARGB(255, 241, 241, 241)
                    .withOpacity(progress),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: _animateClose,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: offsetX >= drawerWidth
                                  ? Hero(
                                      tag: "avatar",
                                      child: SizedBox(
                                        key: _drawerAvatarKey,
                                        height: 70,
                                        width: 70,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: Text('JD',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    )
                                  : SizedBox(height: 80, width: 80),
                            ),
                            SizedBox(height: 20),
                            Text("John Doe",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 70),
                              shrinkWrap: true,
                              itemCount: profileInfo.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    spacing: 5,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 8,
                                          children: [
                                            Text(
                                              profileInfo[index].title,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              profileInfo[index].subtitle,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Simulated Hero Avatar
            if (offsetX < drawerWidth)
              Positioned(
                top: avatarPos.dy,
                left: avatarPos.dx,
                child: SizedBox(
                  height: size,
                  width: size,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text('JD',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum ProfileOptions {
  getHelp("Get Help",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. sed do eiusmod tempor"),
  accountInfo("Account Information",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. sed do eiusmod tempor"),
  privacy("Privacy and Security",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."),
  accounts("Connected accounts",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. sed do eiusmod tempor"),
  preferences("Preferences",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. sed do eiusmod tempor");

  const ProfileOptions(this.title, this.subtitle);
  final String title;
  final String subtitle;
}
