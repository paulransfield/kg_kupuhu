import 'package:kg_router/src/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:kg_router/src/features/products/presentation/products_list/products_grid.dart';
import 'package:kg_router/src/features/products/presentation/products_list/products_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kg_router/src/common_widgets/responsive_center.dart';
import 'package:kg_router/src/constants/app_sizes.dart';

import 'package:iconly/iconly.dart';

// Screens
import '../../../screens/tinderswipe_screen.dart';
import '../../../screens/tile_swipeable.dart';
import '../../../screens/gauge_screen.dart';
import '../../../screens/products_screen.dart';
import '../../../screens/video_page.dart';

/// Shows the list of products with a search field at the top.
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  int currentScreen = 0;
  List<Widget> screens = const [
    TinderSwipe(),
    ProductsScreen(),
    Learn2Screen(),
    ChewieDemo(),
    GaugeScreen()
  ];
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: screens[currentScreen],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(IconlyBold.home), label: 'ūnga'),
          NavigationDestination(icon: Icon(IconlyBold.image_2), label: 'kupu'),
          NavigationDestination(icon: Icon(IconlyBold.bag), label: 'koha'),
          NavigationDestination(icon: Icon(Icons.games), label: 'ataata'),
          NavigationDestination(icon: Icon(IconlyBold.profile), label: 'ko au'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentScreen = index;
          });
        },
        selectedIndex: currentScreen,
      ),
    );
  }
}
