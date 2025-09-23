import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Streaks App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage();
        break;
      case 1:
        page = ManagePage();
        break;
      case 2:
        page = AddPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
      body: Row(
        
        children: [
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 600 ? 175 : null,
              child: NavigationRail(
                unselectedIconTheme: IconThemeData(color: Theme.of(context).highlightColor),
                selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                selectedLabelTextStyle: TextStyle(color: Theme.of(context).canvasColor),
                unselectedLabelTextStyle: TextStyle(color: Theme.of(context).highlightColor),
                indicatorColor: Theme.of(context).canvasColor,
                backgroundColor: Theme.of(context).primaryColor,
                extended: MediaQuery.of(context).size.width > 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home), 
                    label: Text("Home")),
                  NavigationRailDestination(
                    icon: Icon(Icons.manage_search), 
                    label: Text("Manage")),
                  NavigationRailDestination(
                    icon: Icon(Icons.add), 
                    label: Text("Add")),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ) 
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            )
          )
        ],
      ),
    );
    });
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TimeShow()
          ],
        ),
      )
    );
  }
}

class TimeShow extends StatefulWidget{
  @override
  State<TimeShow> createState() => _TimeShowState();
}

class _TimeShowState extends State<TimeShow> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final today = DateTime.now();
    final formattedDate = DateFormat('EEEE, MMMM dd').format(today);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          formattedDate, 
          style: style,),
      ),
    );
  }
}

class ManagePage extends StatefulWidget {
  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Scaffold(
        body: Column(
          children: [Text("Manage Page")],
        ),
      ),
    );
  }
}

class AddPage extends StatefulWidget {
  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Scaffold(
        body: Column(
          children: [Text("Add Page")],
        ),
      ),
    );
  }
}
