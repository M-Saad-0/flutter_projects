import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:msaadcse_portfolio/app_theme.dart';
import 'package:msaadcse_portfolio/constants/my_skills.dart';
import 'package:msaadcse_portfolio/models/project.dart';
import 'package:url_launcher/url_launcher.dart';


class ProjectWidget extends StatelessWidget {
  final Project project;
  const ProjectWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.sizeOf(context).width*.41,
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: ()async {
            await launchUrl(Uri.parse(project.url), webOnlyWindowName: '_blank');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(project.picture, fit: BoxFit.fill, scale: 5,)),
              Wrap(
                children:
                    project.skillsUsed.map((e) {
                      return Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                          color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppThemes.twitterDarkBG.withValues(alpha: 0.5)
                                : AppThemes.twitterLightBG,
          
                                borderRadius: BorderRadius.circular(4)
                                
                    ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox.square(
                              dimension: 10,
                              child:
                                  skillLogoMap[e] == null
                                      ? Icon(Icons.military_tech, size: 10,)
                                      : SvgPicture.string(skillLogoMap[e]!),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              e,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
              Text(
                project.projectName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(project.description),
            ],
          ),
        ),
      ),
    );
  }
}
