import 'package:flutter/material.dart';

class BuildSocialButton extends StatelessWidget {
  // final IconData icon;
  final Widget icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const BuildSocialButton({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // لون خلفية باهت جداً
          borderRadius: BorderRadius.circular(555),
        ),
        child: Center(
          child: Row(
            children: [
              // Icon(
              //   icon,
              //   size: 16,
              //   color: color,
              // ),
              CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: icon,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
