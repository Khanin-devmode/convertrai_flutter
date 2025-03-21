import 'package:convert_rai/features/price_converter/presentation/pages/price_converter_page.dart';
import 'package:convert_rai/features/unit_converter/presentation/pages/unit_converter_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const UnitConverterPage(),
    const PriceConverterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Container(
          height: 270,
          decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
            ),
            gradient: LinearGradient(
              colors: [Color(0xffff8900), Color(0xffffbf74)],
              stops: [0, 1],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Padding(
          padding: defaultTargetPlatform == TargetPlatform.iOS
              ? const EdgeInsets.only(top: 40)
              : const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: _pages.elementAt(_selectedIndex),
          ),
        ),
        // _bannerAd != null
        //     ? Positioned(
        //         bottom: 16,
        //         left: (screenSize.width / 2 - _bannerAd!.size.width / 2),
        //         child: Container(
        //           color: Colors.blue,
        //           width: _bannerAd!.size.width.toDouble(),
        //           height: _bannerAd!.size.height.toDouble(),
        //           alignment: Alignment.center,
        //           child: AdWidget(ad: _bannerAd!),
        //         ))
        //     : const SizedBox()
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined),
            label: appLocal.unitCoverter,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_outlined),
            label: appLocal.priceConverter,
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (_onItemTapped),
      ),
    );
  }
}
