import 'package:flutter/material.dart';
import 'package:reorderable_tabbar/reorderable_tabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reorderable TabBar',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ReorderableTabBarPage(),
    );
  }
}

class ReorderableTabBarPage extends StatefulWidget {
  const ReorderableTabBarPage({Key? key}) : super(key: key);

  @override
  State<ReorderableTabBarPage> createState() => _ReorderableTabBarPageState();
}

extension StringExt on String {
  Text get text => Text(this);
  Widget tab(int index) {
    return SizedBox(
      width: 200,
      child: Tab(
        text: "Tab $this",
      ),
    );
  }
}

class _ReorderableTabBarPageState extends State<ReorderableTabBarPage> {
  PageController pageController = PageController();

  List<String> tabs = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  bool isScrollable = false;
  bool tabSizeIsLabel = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Reorderable TabBar"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Switch(
                  value: tabSizeIsLabel,
                  onChanged: (s) {
                    setState(() {
                      tabSizeIsLabel = s;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Switch(
                  value: isScrollable,
                  onChanged: (s) {
                    setState(() {
                      isScrollable = s;
                    });
                  },
                ),
              ),
            ),
          ],
          bottom: ReorderableTabBar(
            buildDefaultDragHandles: true,
            tabs: tabs.map((e) => e.tab(tabs.indexOf(e))).toList(),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.zero,
            isScrollable: true,
            reorderingTabBackgroundColor: Colors.black45,
            indicatorWeight: 5,
            tabHeaders: const [
              Text("Tab 1"),
              Text("Tab 2"),
              Text("Tab 3"),
              Text("Tab 4"),
              Text("Tab 5"),
              Text("Tab 6"),
              Text("Tab 7"),
              Text("Tab 8"),
              Text("Tab 9"),
              Text("Tab 10"),
            ]
                .map((e) => SizedBox(
                    width: 200,
                    child: Center(
                      child: e,
                    )))
                .toList(),
            tabBorderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            onReorder: (oldIndex, newIndex) async {
              String temp = tabs.removeAt(oldIndex);
              tabs.insert(newIndex, temp);
              setState(() {});
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            tabs.add((tabs.length + 1).toString());
            setState(() {});
          },
        ),
        body: TabBarView(
          children: tabs.map((e) {
            return Center(
              child: ("$e. Page").text,
            );
          }).toList(),
        ),
      ),
    );
  }
}
