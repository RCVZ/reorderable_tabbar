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
  ];

  bool isScrollable = false;
  bool tabSizeIsLabel = false;

  Widget createTabHeader(int tab) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${tab + 1}",
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  tabs.removeAt(tab);
                });
              },
              icon: const Icon(Icons.close))
        ],
      ),
    );
  }

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
            defaultIndicator: true,
            reorderingTabBackgroundColor: Colors.black45,
            indicatorWeight: 5,
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: 4, color: Theme.of(context).colorScheme.onSurface),
            ),
            tabHeaders: List.generate(tabs.length, (index) => createTabHeader(index)),
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
