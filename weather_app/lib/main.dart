import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/using_future.dart';
import 'package:weather_app/services/code_shorter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String id1 = "";
    String id2 = "";
    String id3 = "";
    String id4 = "";
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              child: Text("Store Date"),
              onPressed: () async {
                id1 = await CodeShorter.storeTheCode(
                    '''----Join my leaderboard----
Z+wgivNuklQfH6wH9VATNWxFbuOnITdwWTCayF+sy8vy5Mk3bSfLQjDrpMZpFXQV7ExnZPlVdcXHjIBixq+Pl3R+R5fkQKoBvJw3E31j3bMr/c3GinkCt9PB3XyhNfiJWe/di1W3F6zSe4xrbchuSIGev199KIo7rDkvgDyA5O/iiTVCbTgFhKgAIV7r8u2dxgXc1SvainZ6NJuZO+NVROr/jr+aWhEBvnux/58QxEltOh/e9Si+K5eDPD+XqoLYEIUDqAQc5Gh77Gsqz/3x2PtXwhJnvh4QMV6W/SoaB/gQA/dF5vwS+/cIscqMauKu4+owEzeGAEAIf3L+T9Z0aw==|||||bTSVDxcjVbbyt42ix08OIpcgWp3QesSqneH/h50uux+4TnDf3k1pIWRzInqSGYJ5/4l2Qus4xNqH/dP0vIqYE0PDy6eJR3mpqvXZbwg5+2mQnSTcKY3bJpkjM3jW7ELV+a5b9FDX77cmOmevvH2esQ0M+OPPXLdD9HqYeRsBXfsBUR4k4i+qY3Px4oP3WIMulOqE9AzMSpK0NJN8lufra/E1WCiwXyAtevtbn1knoc4hnzHKSA1vgx/K9zt12JDnkh1xSN88iygK3AUuz12eZ4IltkrR7whWTimT3JbL1Bh1KOHeJpQ2IJEQ0QrxrxhHZ9lfd354/vjLlpzTph/mSg==
----Join my leaderboard----''', "clan");
                id2 = await CodeShorter.storeTheCode(
                    '''----Join my leaderboard----
Z+wgivNuklQfH6wH9VATNWxFbuOnITdwWTCayF+sy8vy5Mk3bSfLQjDrpMZpFXQV7ExnZPlVdcXHjIBixq+Pl3R+R5fkQKoBvJw3E31j3bMr/c3GinkCt9PB3XyhNfiJWe/di1W3F6zSe4xrbchuSIGev199KIo7rDkvgDyA5O/iiTVCbTgFhKgAIV7r8u2dxgXc1SvainZ6NJuZO+NVROr/jr+aWhEBvnux/58QxEltOh/e9Si+K5eDPD+XqoLYEIUDqAQc5Gh77Gsqz/3x2PtXwhJnvh4QMV6W/SoaB/gQA/dF5vwS+/cIscqMauKu4+owEzeGAEAIf3L+T9Z0aw==|||||bTSVDxcjVbbyt42ix08OIpcgWp3QesSqneH/h50uux+4TnDf3k1pIWRzInqSGYJ5/4l2Qus4xNqH/dP0vIqYE0PDy6eJR3mpqvXZbwg5+2mQnSTcKY3bJpkjM3jW7ELV+a5b9FDX77cmOmevvH2esQ0M+OPPXLdD9HqYeRsBXfsBUR4k4i+qY3Px4oP3WIMulOqE9AzMSpK0NJN8lufra/E1WCiwXyAtevtbn1knoc4hnzHKSA1vgx/K9zt12JDnkh1xSN88iygK3AUuz12eZ4IltkrR7whWTimT3JbL1Bh1KOHeJpQ2IJEQ0QrxrxhHZ9lfd354/vjLlpzTph/mSg==
----Join my leaderboard----''', "leaderboard");
                id3 = await CodeShorter.storeTheCode(
                    '''----Join my leaderboard----
Z+wgivNuklQfH6wH9VATNWxFbuOnITdwWTCayF+sy8vy5Mk3bSfLQjDrpMZpFXQV7ExnZPlVdcXHjIBixq+Pl3R+R5fkQKoBvJw3E31j3bMr/c3GinkCt9PB3XyhNfiJWe/di1W3F6zSe4xrbchuSIGev199KIo7rDkvgDyA5O/iiTVCbTgFhKgAIV7r8u2dxgXc1SvainZ6NJuZO+NVROr/jr+aWhEBvnux/58QxEltOh/e9Si+K5eDPD+XqoLYEIUDqAQc5Gh77Gsqz/3x2PtXwhJnvh4QMV6W/SoaB/gQA/dF5vwS+/cIscqMauKu4+owEzeGAEAIf3L+T9Z0aw==|||||bTSVDxcjVbbyt42ix08OIpcgWp3QesSqneH/h50uux+4TnDf3k1pIWRzInqSGYJ5/4l2Qus4xNqH/dP0vIqYE0PDy6eJR3mpqvXZbwg5+2mQnSTcKY3bJpkjM3jW7ELV+a5b9FDX77cmOmevvH2esQ0M+OPPXLdD9HqYeRsBXfsBUR4k4i+qY3Px4oP3WIMulOqE9AzMSpK0NJN8lufra/E1WCiwXyAtevtbn1knoc4hnzHKSA1vgx/K9zt12JDnkh1xSN88iygK3AUuz12eZ4IltkrR7whWTimT3JbL1Bh1KOHeJpQ2IJEQ0QrxrxhHZ9lfd354/vjLlpzTph/mSg==
----Join my leaderboard----''', "clanCoin");
                id4 = await CodeShorter.storeTheCode(
                    '''----Join my leaderboard----
Z+wgivNuklQfH6wH9VATNWxFbuOnITdwWTCayF+sy8vy5Mk3bSfLQjDrpMZpFXQV7ExnZPlVdcXHjIBixq+Pl3R+R5fkQKoBvJw3E31j3bMr/c3GinkCt9PB3XyhNfiJWe/di1W3F6zSe4xrbchuSIGev199KIo7rDkvgDyA5O/iiTVCbTgFhKgAIV7r8u2dxgXc1SvainZ6NJuZO+NVROr/jr+aWhEBvnux/58QxEltOh/e9Si+K5eDPD+XqoLYEIUDqAQc5Gh77Gsqz/3x2PtXwhJnvh4QMV6W/SoaB/gQA/dF5vwS+/cIscqMauKu4+owEzeGAEAIf3L+T9Z0aw==|||||bTSVDxcjVbbyt42ix08OIpcgWp3QesSqneH/h50uux+4TnDf3k1pIWRzInqSGYJ5/4l2Qus4xNqH/dP0vIqYE0PDy6eJR3mpqvXZbwg5+2mQnSTcKY3bJpkjM3jW7ELV+a5b9FDX77cmOmevvH2esQ0M+OPPXLdD9HqYeRsBXfsBUR4k4i+qY3Px4oP3WIMulOqE9AzMSpK0NJN8lufra/E1WCiwXyAtevtbn1knoc4hnzHKSA1vgx/K9zt12JDnkh1xSN88iygK3AUuz12eZ4IltkrR7whWTimT3JbL1Bh1KOHeJpQ2IJEQ0QrxrxhHZ9lfd354/vjLlpzTph/mSg==
----Join my leaderboard----''', "leaderboardCoin");
              },
            ),
            TextButton(
              child: Text("Get Data"),
              onPressed: () async {
                await CodeShorter.getTheCode(id1, "clan");
                await CodeShorter.getTheCode(id2, "leaderboard");
                await CodeShorter.getTheCode(id3, "clanCoin");
                await CodeShorter.getTheCode(id4, "leaderboardCoin");
              },
            )
          ],
        ),
      ),
    ));
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  List<Widget> wds = [
    const HomePage(),
    const WeatherApiScreen(),
    const Center(child: Text("Item No 3")),
    const Center(child: Text("Item No 4")),
    const Center(child: Text("Item No 5"))
  ];
  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wds.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.wind_power_sharp), label: "Weather"),
          BottomNavigationBarItem(
              icon: Icon(Icons.flaky_outlined), label: "Using Json"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person3"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person4"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person5"),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 30,
        unselectedItemColor: Colors.purpleAccent,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onTap,
        showUnselectedLabels: true,
      ),
    );
  }
}
