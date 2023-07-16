// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// final GlobalKey<NavigatorState> _rootNavigatorKey =
// GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey =
// GlobalKey<NavigatorState>(debugLabel: 'shell');
//
// // This scenario demonstrates how to set up nested navigation using ShellRoute,
// // which is a pattern where an additional Navigator is placed in the widget tree
// // to be used instead of the root navigator. This allows deep-links to display
// // pages along with other UI components such as a BottomNavigationBar.
// //
// // This example demonstrates how to display a route within a ShellRoute and also
// // push a screen using a different navigator (such as the root Navigator) by
// // providing a `parentNavigatorKey`.
//
// void main() {
//   runApp(ShellRouteExampleApp());
// }
//
// /// An example demonstrating how to use [ShellRoute]
// class ShellRouteExampleApp extends StatelessWidget {
//   /// Creates a [ShellRouteExampleApp]
//   ShellRouteExampleApp({super.key});
//
//   final GoRouter _router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     initialLocation: '/a',
//     debugLogDiagnostics: true,
//     routes: <RouteBase>[
//       /// Application shell
//       ShellRoute(
//         navigatorKey: _shellNavigatorKey,
//         builder: (BuildContext context, GoRouterState state, Widget child) {
//           return ScaffoldWithNavBar(child: child);
//         },
//         routes: <RouteBase>[
//           /// The first screen to display in the bottom navigation bar.
//           GoRoute(
//             path: '/a',
//             builder: (BuildContext context, GoRouterState state) {
//               return const ScreenA();
//             },
//             routes: <RouteBase>[
//               // The details screen to display stacked on the inner Navigator.
//               // This will cover screen A but not the application shell.
//               GoRoute(
//                 path: 'details',
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const DetailsScreen(label: 'A');
//                 },
//               ),
//             ],
//           ),
//
//           /// Displayed when the second item in the the bottom navigation bar is
//           /// selected.
//           GoRoute(
//             path: '/b',
//             builder: (BuildContext context, GoRouterState state) {
//               return const ScreenB();
//             },
//             routes: <RouteBase>[
//               /// Same as "/a/details", but displayed on the root Navigator by
//               /// specifying [parentNavigatorKey]. This will cover both screen B
//               /// and the application shell.
//               GoRoute(
//                 path: 'details',
//                 parentNavigatorKey: _rootNavigatorKey,
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const DetailsScreen(label: 'B');
//                 },
//               ),
//             ],
//           ),
//
//           /// The third screen to display in the bottom navigation bar.
//           GoRoute(
//             path: '/c',
//             builder: (BuildContext context, GoRouterState state) {
//               return const ScreenC();
//             },
//             routes: <RouteBase>[
//               // The details screen to display stacked on the inner Navigator.
//               // This will cover screen A but not the application shell.
//               GoRoute(
//                 path: 'details',
//                 builder: (BuildContext context, GoRouterState state) {
//                   return const DetailsScreen(label: 'C');
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       routerConfig: _router,
//     );
//   }
// }
//
// /// Builds the "shell" for the app by building a Scaffold with a
// /// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
// class ScaffoldWithNavBar extends StatelessWidget {
//   /// Constructs an [ScaffoldWithNavBar].
//   const ScaffoldWithNavBar({
//     required this.child,
//     super.key,
//   });
//
//   /// The widget to display in the body of the Scaffold.
//   /// In this sample, it is a Navigator.
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: child,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'A Screen',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: 'B Screen',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notification_important_rounded),
//             label: 'C Screen',
//           ),
//         ],
//         currentIndex: _calculateSelectedIndex(context),
//         onTap: (int idx) => _onItemTapped(idx, context),
//       ),
//     );
//   }
//
//   static int _calculateSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).location;
//     if (location.startsWith('/a')) {
//       return 0;
//     }
//     if (location.startsWith('/b')) {
//       return 1;
//     }
//     if (location.startsWith('/c')) {
//       return 2;
//     }
//     return 0;
//   }
//
//   void _onItemTapped(int index, BuildContext context) {
//     switch (index) {
//       case 0:
//         GoRouter.of(context).go('/a');
//         break;
//       case 1:
//         GoRouter.of(context).go('/b');
//         break;
//       case 2:
//         GoRouter.of(context).go('/c');
//         break;
//     }
//   }
// }
//
// /// The first screen in the bottom navigation bar.
// class ScreenA extends StatelessWidget {
//   /// Constructs a [ScreenA] widget.
//   const ScreenA({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Screen A'),
//             TextButton(
//               onPressed: () {
//                 GoRouter.of(context).go('/a/details');
//               },
//               child: const Text('View A details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// The second screen in the bottom navigation bar.
// class ScreenB extends StatelessWidget {
//   /// Constructs a [ScreenB] widget.
//   const ScreenB({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Screen B'),
//             TextButton(
//               onPressed: () {
//                 GoRouter.of(context).go('/b/details');
//               },
//               child: const Text('View B details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// The third screen in the bottom navigation bar.
// class ScreenC extends StatelessWidget {
//   /// Constructs a [ScreenC] widget.
//   const ScreenC({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Screen C'),
//             TextButton(
//               onPressed: () {
//                 GoRouter.of(context).go('/c/details');
//               },
//               child: const Text('View C details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// The details screen for either the A, B or C screen.
// class DetailsScreen extends StatelessWidget {
//   /// Constructs a [DetailsScreen].
//   const DetailsScreen({
//     required this.label,
//     super.key,
//   });
//
//   /// The label to display in the center of the screen.
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Details Screen'),
//       ),
//       body: Center(
//         child: Text(
//           'Details for $label',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//       ),
//     );
//   }
// }
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

void main() {
  runApp(
    // Consistent AppBar and Bottom Nav Bar
    // ConfigARoutes(),
    // Consistent Bottom Nav Bar
    NestedTabNavigationExampleApp(),
  );
}

class ConfigARoutes extends StatelessWidget {
  ConfigARoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/a',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return RootOfTheApp(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            // Tab 1
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/a',
                builder: (BuildContext context, GoRouterState state) {
                  return const PageA1();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'a2',
                    builder: (BuildContext context, GoRouterState state) {
                      return const PageA2();
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            // Tab 2

            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) {
                  return const PageB1();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'b2/:param',
                    builder: (BuildContext context, GoRouterState state) {
                      return PageB2(
                        param: state.pathParameters['param'],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            // Tab 3
            routes: <RouteBase>[
              GoRoute(
                path: '/c',
                builder: (BuildContext context, GoRouterState state) {
                  return const PageC1();
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'c2',
                    builder: (BuildContext context, GoRouterState state) {
                      return PageC2(
                        extra: state.extra,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class RootOfTheApp extends StatelessWidget {
  const RootOfTheApp({required this.navigationShell, Key? key})
      : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                GoRouter.of(context).pop();
              } else {
                if (kDebugMode) {
                  print('open menu');
                }
              }
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('app bar'),
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class PageA1 extends StatelessWidget {
  const PageA1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'A 1',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/a/a2');
            },
            child: const Text('go to a2'),
          ),
        ],
      ),
    );
  }
}

class PageA2 extends StatelessWidget {
  const PageA2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(child: Text('page A2')),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('go back to A1'),
        ),
      ],
    );
  }
}

class PageB1 extends StatelessWidget {
  const PageB1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'B1',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/b/b2/p');
            },
            child: const Text('go to B2 with pram p'),
          ),
        ],
      ),
    );
  }
}

class PageB2 extends StatelessWidget {
  const PageB2({this.param, super.key});
  final String? param;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('page B2 with param:->  $param.'));
  }
}

class PageC1 extends StatelessWidget {
  const PageC1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'C1',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/c/c2', extra: 'ABC');
            },
            child: const Text('go to B2 with extra info => ABC '),
          ),
        ],
      ),
    );
  }
}

class PageC2 extends StatelessWidget {
  const PageC2({this.extra, super.key});
  final Object? extra;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Extra info found from C1 is :->  $extra.'));
  }
}

//______________________________Example from internet___________________________
// Here the app bar is different for every page.

/// An example demonstrating how to use nested navigators
class NestedTabNavigationExampleApp extends StatelessWidget {
  NestedTabNavigationExampleApp({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/a',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // Tab 1
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/a',
                builder: (BuildContext context, GoRouterState state) =>
                    const RootScreen(label: 'A', detailsPath: '/a/details'),
                routes: <RouteBase>[
                  // The details screen to display stacked on navigator of the
                  // first tab. This will cover screen A but not the application
                  // shell (bottom navigation bar).
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) =>
                        const DetailsScreen(label: 'A'),
                  ),
                ],
              ),
            ],
          ),

          // Tab 2
          StatefulShellBranch(
            // It's not necessary to provide a navigatorKey if it isn't also
            // needed elsewhere. If not provided, a default key will be used.
            routes: <RouteBase>[
              GoRoute(
                path: '/b',
                builder: (BuildContext context, GoRouterState state) {
                  return const RootScreen(
                    label: 'B',
                    detailsPath: '/b/details/1',
                    secondDetailsPath: '/b/details/2',
                  );
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details/:param',
                    builder: (BuildContext context, GoRouterState state) {
                      return DetailsScreen(
                        label: 'B',
                        param: state.pathParameters['param'],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Tab 3
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/c',
                builder: (BuildContext context, GoRouterState state) {
                  return const RootScreen(
                    label: 'C',
                    detailsPath: '/c/details',
                  );
                },
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (BuildContext context, GoRouterState state) {
                      return DetailsScreen(
                        label: 'C',
                        extra: state.extra,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  const RootScreen({
    required this.label,
    required this.detailsPath,
    this.secondDetailsPath,
    super.key,
  });

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  /// The path to another detail page
  final String? secondDetailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Root of section $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Screen $label',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath, extra: '$label-XYZ');
              },
              child: const Text('View details'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            if (secondDetailsPath != null)
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go(secondDetailsPath!);
                },
                child: const Text('View more details'),
              ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    required this.label,
    this.param,
    this.extra,
    this.withScaffold = true,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  /// Optional param
  final String? param;

  /// Optional extra object
  final Object? extra;

  /// Wrap in scaffold
  final bool withScaffold;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.withScaffold) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen - ${widget.label}'),
        ),
        body: _build(context),
      );
    } else {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _build(context),
      );
    }
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Details for ${widget.label} - Counter: $_counter',
              style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.param != null)
            Text('Parameter: ${widget.param!}',
                style: Theme.of(context).textTheme.titleMedium),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.extra != null)
            Text('Extra: ${widget.extra!}',
                style: Theme.of(context).textTheme.titleMedium),
          if (!widget.withScaffold) ...<Widget>[
            const Padding(padding: EdgeInsets.all(16)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('< Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ]
        ],
      ),
    );
  }
}
