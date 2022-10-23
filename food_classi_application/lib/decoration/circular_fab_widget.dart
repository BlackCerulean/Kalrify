import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_classi_application/component/DA_component.dart';
import 'hero_dialog_route.dart';

final double buttonSize = 70;

class CircularFabWidget extends StatefulWidget {
  @override
  State<CircularFabWidget> createState() => _CircularFabWidgetState();
}

class _CircularFabWidgetState extends State<CircularFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  int count = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Flow(
        delegate: FlowMenuDelegate(controller: controller),
        children: <IconData>[
          Icons.bookmark_add_outlined,
          Icons.analytics_outlined,
          Icons.add_photo_alternate_outlined,
          Icons.menu,
        ].map<Widget>(buildFAB).toList(),
      );

  Widget buildFAB(IconData icon) => SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF8cb369),
          elevation: 0,
          splashColor: Colors.black,
          child: Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            if (icon == Icons.bookmark_add_outlined) {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                var dt = DateTime.now();
                return addDiary(
                  day: dt.day.toString(),
                  month: dt.month.toString(),
                  year: dt.year.toString(),
                  hour: dt.hour.toString(),
                  minute: dt.minute,
                );
              }));
            } else if (icon == Icons.analytics_outlined) {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return Viewmeal();
              }));
            } else if (icon == Icons.add_photo_alternate_outlined) {
              Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                return selectImage();
              }));
            } else if (controller.status == AnimationStatus.completed) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          heroTag: null,
        ),
      );
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - buttonSize;
    final yStart = size.height - buttonSize;

    final n = context.childCount;
    for (int i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;

      final radius = 120 * controller.value;

      final theta = i * pi * 0.5 / (n - 2);
      final x = xStart - setValue(radius * cos(theta));
      final y = yStart - setValue(radius * sin(theta));
      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(buttonSize / 2, buttonSize / 2)
            ..rotateZ(
                isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
            ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
            ..translate(-buttonSize / 2, -buttonSize / 2));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}
