import 'package:contributions_chart/contributions_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:portfolio/app_theme.dart';
import 'package:portfolio/constants/my_contacts.dart';
import 'package:portfolio/constants/my_projects.dart';
import 'package:portfolio/constants/my_skills.dart';
import 'package:portfolio/constants/svgs.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:portfolio/providers/visitor_provider.dart';
// import 'package:portfolio/services/live_visitor_manager.dart';
import 'package:portfolio/widgets/project_widget.dart';
import 'package:portfolio/widgets/skill_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  final ScrollController _scrollController = ScrollController();
  late int gitHubYear;
  late String urlPrefix;

  @override
  void initState() {
    gitHubYear = DateTime.now().year;
     urlPrefix = kIsWeb ? 'https://api.codetabs.com/v1/proxy?quest=' : '';
    _scrollController.addListener(() {});
    super.initState();
    // Initialize AnimationController
    _textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    // Fade animation for the hero section
    _textAnimationController.forward();
    // LiveVisitorManager().connect();
    context.read<VisitorProvider>().db.incrementTotalVisitor();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    // context.read<VisitorProvider>().db.decrementLiveVisitor();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool currentTheme = Provider.of<ThemeProvider>(context).isDark;
    final stats = context.watch<VisitorProvider>().stats;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:
                currentTheme
                    ? Color(0xFF192734).withValues(alpha: 0.85)
                    : Color(0xFFF5F8FA).withValues(alpha: 0.85),
            leading: SvgPicture.string(flutter),
            title: Text(
              "Saad's Portfolio",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            floating: true,
            actions: [
              IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
                icon: Icon(
                  currentTheme ? Icons.light_mode : Icons.dark_mode,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Card(
              margin: Theme.of(context).cardTheme.margin,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    if (constraint.maxWidth > 666) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: heroWidgets(currentTheme),
                      );
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: heroWidgets(currentTheme).reversed.toList(),
                    );
                  },
                ),
              ),
            ),
          ),

          //Skill
          SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(),
                Text(
                  textAlign: TextAlign.center,
                  "Skills",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  // height: (300),
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Wrap(children: skillWidgets(constraints.maxWidth)),
                  ),
                );
              },
            ),
          ),

          //Projects
          SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(),
                Text(
                  textAlign: TextAlign.center,
                  "Projects",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Center(child: Wrap(children: projectWidgets())),
          ),
          // Contacts
          SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(),
                Text(
                  textAlign: TextAlign.center,
                  "GitHub Contributions",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (context, constraints) {
                
                 
                    return githubContributionsWidget(
                      constraints.maxHeight - 40,
                      constraints.maxWidth - 50,
                      context,
                    );
               
              },
            ),
          ),

          SliverToBoxAdapter(
            child: Center(
              child: Container(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppThemes.twitterLightBG.withValues(alpha: 0.1)
                        : AppThemes.twitterDarkBG.withValues(alpha: 0.1),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Made with 💙 by ",
                        children: [
                          TextSpan(
                            text: "Muhammad Saad",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: " with ",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: "Flutter",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: contacts(),
                        ),

                        Text("Views : ${stats['total_visitors']}"),
                        // Text("Live Visitor: ${stats['live_visitors']},\t\tTotal Visitor: ${stats['total_visitors']}")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> heroWidgets(bool isDark) => [
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback:
              (Rect bound) => LinearGradient(
                colors:
                    isDark
                        ? [AppThemes.twitterBlue, AppThemes.accentTeal]
                        : [
                          AppThemes.twitterBlue,
                          AppThemes.accentTeal.withValues(alpha: 0.8),
                        ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bound),
          blendMode: BlendMode.srcIn,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<int>(
                duration: Duration(milliseconds: 1000),
                tween: IntTween(
                  begin: 0,
                  end: "Junior Flutter Developer".length,
                ),
                curve: Curves.bounceIn,
                builder: (context, val, child) {
                  return Text(
                    "Junior Flutter Developer".substring(0, val),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              TweenAnimationBuilder<int>(
                duration: Duration(milliseconds: 1000),
                tween: IntTween(begin: 0, end: "Muhammad Saad".length),
                curve: Curves.bounceIn,
                builder: (context, val, child) {
                  return Text(
                    "Muhammad Saad".substring(0, val),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 1000),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          curve: Curves.bounceIn,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Wrap(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await launchUrl(Uri.parse("mailto:msaad97.se@gmail.com"));
                    },
                    label: Text(
                      "Hire Me",
                      // style: Theme.of(context).textTheme.labelLarge,
                    ),
                    icon: Icon(Icons.code, size: 20),
                    style: Theme.of(context).elevatedButtonTheme.style,
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse("assets/muhammad_saad_cv.pdf"));
                    },

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "Downlaod CV",
                          // style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    // style: Theme.of(context).elevatedButtonTheme.style,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ),
    SizedBox(
      height: 350,
      child: Stack(
        children: [
          Positioned(bottom: 50, child: CircleAvatar(radius: 100)),
          Positioned(
            // top: -50,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
              child: Image(image: AssetImage("images/user.png"), height: 300),
            ),
          ),
        ],
      ),
    ),
  ];

  List<Widget> skillWidgets(double currentWidth) {
    return mySkill
        .map(
          (e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SkillWidget(
              skillName: e.skillName,
              currentWidth: currentWidth,
              iconUrl: e.iconUrl,
              skillLevel: e.skillLevel,
              endDuration: (mySkill.indexOf(e) + 1) * 500,
              skillColor: e.color,
            ),
          ),
        )
        .toList();
  }

  List<Widget> projectWidgets() {
    return myProjects.map((e) => ProjectWidget(project: e)).toList();
  }

  List<Widget> contacts() {
    return myContacts.entries.map((e) {
      return InkWell(
        onTap: () async {
          await launchUrl(Uri.parse(e.value));
        },
        child: SvgPicture.string(getLogo(e.key), width: 65),
      );
    }).toList();
  }

  Widget githubContributionsWidget(
    double height,
    double width,
    BuildContext context,
  ) {
    print(gitHubYear);

   return Container();
  }

  // Widget selectGithubYear() {
  //   int nowYear = DateTime.now().year;
  //   return SizedBox(
  //     height: 300,
  //     child: Column(
  //       children: List.generate(nowYear - 2020, (i) {
  //         return Material(
  //           borderRadius: BorderRadius.circular(5),
  //           child: InkWell(
  //             onTap: () {
  //               setState(() {
  //                 gitHubYear = nowYear - i;
  //               });
  //             },
  //             child: Container(
  //               alignment: Alignment.center,
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 color:
  //                     gitHubYear == nowYear - i
  //                         ? Theme.of(context).primaryColor
  //                         : null,
  //                 borderRadius: BorderRadius.all(Radius.circular(5)),
  //               ),
  //               child: Text((nowYear - i).toString()),
  //             ),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }
}
