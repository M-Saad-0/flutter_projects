import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:msaadcse_portfolio/app_theme.dart';
import 'package:msaadcse_portfolio/constants/my_contacts.dart';
import 'package:msaadcse_portfolio/constants/my_projects.dart';
import 'package:msaadcse_portfolio/constants/my_skills.dart';
import 'package:msaadcse_portfolio/constants/svgs.dart';
import 'package:msaadcse_portfolio/providers/github_contribution_provivder.dart';
import 'package:msaadcse_portfolio/providers/theme_provider.dart';
import 'package:msaadcse_portfolio/providers/visitor_provider.dart';
import 'package:msaadcse_portfolio/widgets/heat_map_chart.dart';
// import 'package:msaadcse_portfolio/services/live_visitor_manager.dart';
import 'package:msaadcse_portfolio/widgets/project_widget.dart';
import 'package:msaadcse_portfolio/widgets/skill_widget.dart';
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
  late bool currentTheme;
  @override
  void initState() {
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
    currentTheme = Provider.of<ThemeProvider>(context).isDark;
    final stats = context.watch<VisitorProvider>().stats;
    List<Map<String, dynamic>> yearData =
        Provider.of<GithubContributionProvivder>(context).yearDate;
    final startYear = 2020;
    final totalYears = DateTime.now().year - 2020;
    final selectedYear =
        Provider.of<GithubContributionProvivder>(context).selectedYear;
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
            actionsPadding: EdgeInsets.symmetric(horizontal: 16),
            actions: [...contacts(MediaQuery.sizeOf(context).width)],
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                // height: 350 ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: totalYears + 1,
                        reverse: true,

                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,

                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  selectedYear == index + startYear
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<GithubContributionProvivder>()
                                    .loadYearData(year: startYear + index);
                              },
                              child: Column(
                                children: [
                                  Text((startYear + index).toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      // Or Flexible if you want dynamic sizing
                      child: HeatMapChart(year: yearData),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(children: [Divider(), const SizedBox(height: 15)]),
          ),

          SliverToBoxAdapter(
            child: Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: currentTheme ? Color(0xFF192734) : Colors.white,
                
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Made with 💙 by ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 13,
                        ),
                        children: [
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () async {
                                    await launchUrl(
                                      Uri.parse(
                                        "https://www.linkedin.com/in/muhammad-saad-a583b9230/",
                                      ),
                                    );
                                  },
                            text: "Muhammad Saad",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                            text: " using ",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () async {
                                    await launchUrl(
                                      Uri.parse("https://www.flutter.dev"),
                                    );
                                  },
                            text: "Flutter",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text: "Views : ",
                          children: [
                            TextSpan(
                              text: "${stats['total_visitors']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " \t | \t  ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "Live Viewers : ",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: "${stats['live_visitors']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
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
                tween: IntTween(begin: 0, end: "Flutter Developer".length),
                curve: Curves.bounceIn,
                builder: (context, val, child) {
                  return Text(
                    "Flutter Developer".substring(0, val),
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
                curve: Curves.easeIn,
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
          curve: Curves.easeIn,
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
              child: Image(
                image: AssetImage("assets/images/user.png"),
                height: 300,
              ),
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

  dynamic contacts(double width) {
    if (width < 550) {
      List<PopupMenuItem> widgetList =
          myContacts.entries.map<PopupMenuItem>((e) {
              return PopupMenuItem(
                onTap: () async {
                  await launchUrl(Uri.parse(e.value));
                },
                child: Row(
                  children: [
                    SvgPicture.string(
                      getLogo(e.key),
                      width: 28,
                      colorFilter: ColorFilter.mode(
                        currentTheme ? Colors.white70 : Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(e.key),
                  ],
                ),
              );
            }).toList()
            ..add(
              PopupMenuItem(
                onTap: () {
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
                child: Row(
                  children: [
                    Icon(
                      currentTheme ? Icons.light_mode : Icons.dark_mode,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 10),
                    Text("Change Theme"),
                  ],
                ),
              ),
            );

      return [
        PopupMenuButton(
          itemBuilder: (context) => widgetList,
          tooltip: "Contacts & Theme",
          child: Icon(Icons.menu),
        ),
      ];
    }

    List<Widget> widgetList =
        myContacts.entries.map<Widget>((e) {
            return InkWell(
              onTap: () async {
                await launchUrl(Uri.parse(e.value));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.string(
                  getLogo(e.key),
                  width: 28,
                  colorFilter: ColorFilter.mode(
                    currentTheme ? Colors.white70 : Colors.black87,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          }).toList()
          ..add(VerticalDivider())
          ..add(
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
          );
    return widgetList;
  }
}
