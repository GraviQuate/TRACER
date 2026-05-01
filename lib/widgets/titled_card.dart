import 'package:flutter/material.dart';
import 'package:tracer/utils/constants.dart';

class TitledCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const TitledCard({
    super.key,
    required this.title,
    required this.children,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDesign.defaultBoxShadows,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        spacing: 5.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppDesign.subHeading1Style),
          const Divider(color: Colors.grey),
          ...children,
        ],
      ),
    );
  }
}
