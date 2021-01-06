import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const testDevices = 'Mobile id';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevices != null ? <String>[testDevices] : null,
      nonPersonalizedAds: true,
      keywords: <String>['Game', 'Mario']);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: MyApp.targetingInfo,
        listener: (MobileAdEvent event) {
          print('BannerAd $event');
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        // size: AdSize.banner,
        targetingInfo: MyApp.targetingInfo,
        listener: (MobileAdEvent event) {
          print('BannerAd $event');
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AdMob Flutter"),
        ),
        body: Center(
          child: RaisedButton(
              child: Text('AD'),
              onPressed: () {
                createInterstitialAd()
                  ..load()
                  ..show();
              }),
        ),
      ),
    );
  }
}
