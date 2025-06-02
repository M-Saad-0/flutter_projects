import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillWidget extends StatelessWidget {
  final String skillName;
  final String iconUrl;
  final double skillLevel;
  final int endDuration;
  final Color skillColor;
  final double currentWidth;

  const SkillWidget({
    super.key,
    required this.skillName,
    required this.iconUrl,
    required this.skillLevel,
    required this.endDuration,
    required this.skillColor,
    required this.currentWidth
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: skillColor,
      child: SizedBox.square(
        dimension: currentWidth<510? 100:200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TweenAnimationBuilder(
              duration: Duration(milliseconds: endDuration),
              tween: Tween<double>(begin: 0, end: skillLevel),
              builder: (context, val, child) => Stack(
                children: [
                  Positioned(
                    right: !(currentWidth<510)?25:10,
                    top: !(currentWidth<510)?25:10,
                    child: SizedBox(
                      height: !(currentWidth<510)? 50:30,
                      width: !(currentWidth<510)? 50:30,
                      child: SvgPicture.string(iconUrl),
                    ),
                  )
                
                    ,
                     SizedBox.square(
                      dimension: !(currentWidth<510)?100:50,
                       child: CircularProgressIndicator(
                        strokeWidth: !(currentWidth<510)?15:5,
                        color: skillColor,
                        value: val,
                        // minHeight: 10,
                        backgroundColor: Colors.grey.shade300,
                                   ),
                     ),
                  
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Text(skillName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
