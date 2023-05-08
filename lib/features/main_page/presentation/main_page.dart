import 'package:convert_rai/ad_helper.dart';
import 'package:convert_rai/features/price_converter/presentation/price_converter_page.dart';
import 'package:convert_rai/features/unit_converter/presentation/pages/unit_converter_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          // print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
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
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent),
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
        _bannerAd != null
            ? Positioned(
                bottom: 16,
                left: (screenSize.width / 2 - _bannerAd!.size.width / 2),
                child: Container(
                  color: Colors.blue,
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  alignment: Alignment.center,
                  child: AdWidget(ad: _bannerAd!),
                ))
            : const SizedBox()
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle_outlined),
            label: 'Unit Converter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_exchange_outlined),
            label: 'Price Converter',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (_onItemTapped),
      ),
    );
  }
}
