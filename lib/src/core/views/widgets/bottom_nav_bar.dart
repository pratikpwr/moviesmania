import 'package:flutter/material.dart';
import 'package:movie_mania/src/features/search_movies/screens/profile_screen.dart';
import 'package:movie_mania/src/features/search_movies/screens/search_movies_screen.dart';

import '../../../features/home/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchMoviesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

        debugPrint('isFirstRouteInCurrentTab: $isFirstRouteInCurrentTab');

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all<TextStyle>(
              theme.textTheme.subtitle2!.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
            indicatorColor: theme.colorScheme.secondaryContainer,
            iconTheme: MaterialStateProperty.all<IconThemeData>(
              IconThemeData(
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          ),
          child: NavigationBar(
            backgroundColor: theme.colorScheme.background,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                ),
                selectedIcon: Icon(
                  Icons.home_rounded,
                ),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.search_outlined,
                ),
                selectedIcon: Icon(
                  Icons.search_rounded,
                ),
                label: "Search",
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.person_outline_rounded,
                ),
                selectedIcon: Icon(
                  Icons.person_rounded,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/bottomNavBar': (context) {
        return [
          HomeScreen(),
          SearchMoviesScreen(),
          ProfileScreen(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    Map<String, Widget Function(BuildContext)> routeBuilders =
        _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
