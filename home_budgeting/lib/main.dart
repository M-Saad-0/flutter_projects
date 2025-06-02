import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:home_budgeting/blocs/expane_bloc/expanse_bloc.dart';
import 'package:home_budgeting/blocs/monthly_report_bloc/monthly_report_bloc.dart';
import 'package:home_budgeting/blocs/theme_bloc/theme_bloc.dart';
import 'package:home_budgeting/core/constants/months.dart';
import 'package:home_budgeting/core/theme_data/app_theme.dart';
import 'package:home_budgeting/models/expanse.dart';
import 'package:home_budgeting/services/expanse_servcie.dart';
import 'package:home_budgeting/services/monthly_expanse_service.dart';
import 'package:home_budgeting/views/monthly_report.dart';
import 'package:home_budgeting/widgets/expanse_entry_dialog.dart';
import 'package:home_budgeting/widgets/expanse_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpanseAdapter());
  await Hive.openBox<Expanse>("expanse");
  await Hive.openBox("misc");
  await Hive.openBox("chat");

  await MonthlyExpanseService.storeDummyDate(); // temp
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(
          create:
              (context) =>
                  ExpanseBloc(expanseServcie: ExpanseServcie())
                    ..add(GetExpanses()),
        ),
        BlocProvider(create: (context)=>MonthlyReportBloc(monthlyExpanseService: MonthlyExpanseService()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Expanse App',
          theme:
              (state as ThemeThemeToggledState).isDark
                  ? AppTheme().darkTheme
                  : AppTheme().lightTheme,
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchVal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text("Toggle Theme"),
              trailing: Switch(
                value: switchVal,
                onChanged: (v) {
                  setState(() {
                    switchVal = !switchVal;
                    context.read<ThemeBloc>().add(ThemeToggleEvent());
                  });
                },
              ),
            ),
            ListTile(
              title: Text("View Monthly Report"),
              trailing: Switch(
                value: switchVal,
                onChanged: (v) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MonthlyReport()));
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text("Expenses")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ExpanseBloc, ExpanseState>(
          builder: (context, state) {
            switch (state) {
              case ExpanseLoading():
                return Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent),
                );
              case ExpanseLoaded():
                {
                  if (state.expanses.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.now_widgets_sharp, size: 50),
                          const SizedBox(height: 10),
                          Text("No expanse Found"),
                        ],
                      ),
                    );
                  }
int previousMonth = -1;
int previousYear = -1;
                  return ListView.builder(
                    itemCount: state.expanses.length,
                    itemBuilder: (context, index) {
                      final date = DateTime.parse(state.expanses[index].date);
                      if (previousMonth!=date.month && previousYear!=date.year) {
                      previousMonth = date.month;
                      previousYear = date.year;

                        return Column(
                          children: [
                            Text("${months[date.month - 1]} ${date.year}"),
                             ExpanseWidget(expanse: state.expanses[index])
                          ],
                        );
                      }
                      previousMonth = date.month;
                      return ExpanseWidget(expanse: state.expanses[index]);
                    },
                  );
                }
              case ExpanseError():
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 50),
                      const SizedBox(height: 10),
                      Text(state.message),
                    ],
                  ),
                );
              default:
                return Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Expanse? expanse = await showExpanseEnryDialog(context);
          print(expanse);
          if (expanse != null) {
            context.read<ExpanseBloc>().add(AddExpanse(expanse));
            context.read<ExpanseBloc>().add(GetExpanses());
          }
        },
      ),
    );
  }
}
