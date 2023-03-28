import 'package:convert_rai/ad_helper.dart';
import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/presentation/converter_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBgColor,
          elevation: 0,
          centerTitle: false,
          title: const CustomAppBarTitle(),
        ),
        body: Container(
          color: kBgColor,
          child: Column(
            children: [
              const Expanded(
                child: ConverterPage(),
              ),
              _bannerAd != null
                  ? SafeArea(
                      bottom: true,
                      child: Container(
                        color: Colors.blue,
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        alignment: Alignment.center,
                        // child: Text('Ad Banner'),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    )
                  : Row(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          flex: 6,
          child: Text(
            'Convert Rai',
            style: kTitleTextStyle,
          ),
        ),
        Flexible(
          flex: 6,
          child: Container(
            height: 8,
            decoration: const BoxDecoration(
              color: kTitleColor,
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
