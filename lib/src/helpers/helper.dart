import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../generated/l10n.dart';
import '../elements/CircularLoadingWidget.dart';

class Helper {
  BuildContext context;
  DateTime currentBackPressTime;

  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  static final String LANG_ENGLISH = 'English';
  static final String LANG_ENGLISH_CODE = 'us';
  static double HEADER_HEIGHT = 400;
  static int MAX_ALLOWED_FAV = 40;

  static String help_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vulputate, augue a condimentum cursus, sapien neque varius mi, eu tempor ex nulla nec diam. Donec augue augue, commodo et sagittis a, commodo sed urna. Nulla rutrum ante ac eleifend hendrerit. Pellentesque viverra elementum lorem non accumsan. Integer nec tortor eu lectus euismod euismod. Sed egestas libero vel mattis fermentum. Aliquam lacinia varius tristique. Ut at cursus velit. Morbi viverra ligula eu nunc auctor, scelerisque tincidunt velit ultricies. Pellentesque eleifend arcu ex, vitae finibus enim ullamcorper ac. Nam condimentum, tellus et dignissim tincidunt, libero ex dapibus ligula, pellentesque sodales libero lorem vitae orci.\n\nVivamus feugiat, felis vitae molestie maximus, dolor dolor mollis neque, nec auctor arcu ex ac elit. Aenean ac ante gravida, congue eros eu, imperdiet purus. Fusce vitae dui quis elit porttitor elementum vel at mi. Proin malesuada commodo pulvinar. Donec gravida ut est in sodales. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam feugiat purus in ligula pellentesque, vitae auctor justo eleifend.\n\nCurabitur fermentum, massa vitae maximus rhoncus, nunc justo tincidunt diam, sit amet lacinia justo dui sit amet tortor. Cras in purus nec purus accumsan ultricies. Nunc risus dolor, euismod sit amet sapien eu, consectetur rutrum metus. Suspendisse venenatis vitae mauris sed vulputate. Nullam mollis erat sed nunc accumsan, eu pellentesque dui sollicitudin. Quisque non tincidunt nibh. Proin et ex vel diam auctor vulputate. Proin interdum massa eget lectus consectetur, placerat elementum nisl auctor. Ut nec lectus cursus, dignissim enim vel, sollicitudin dui. Aliquam blandit, nunc sit amet pretium bibendum, diam orci venenatis tellus, a fringilla metus nunc vitae felis. Donec placerat lorem ut nisi vestibulum, cursus accumsan ligula consequat. Proin sit amet vestibulum nisi. Suspendisse id imperdiet felis, in luctus diam.\n\nNulla eu diam at sapien pretium aliquam. Integer euismod scelerisque arcu, sed blandit sapien rutrum et. Donec ultricies ligula erat, a venenatis mauris cursus sit amet. In dapibus laoreet enim eu tempus. Mauris commodo sed mi id tempor. Maecenas et velit odio. Donec tincidunt semper ipsum. Donec finibus pellentesque pulvinar. Duis volutpat sagittis dui, quis pretium nibh porta in. Ut condimentum, augue eget rhoncus maximus, nulla nibh euismod nunc, eu maximus mauris lorem nec felis. Donec et massa in leo efficitur maximus. Vestibulum tempus sed augue ac rhoncus. Quisque ut porttitor ipsum, in sagittis odio. Nunc tincidunt risus vel velit condimentum dapibus.\n\nSed lacus augue, iaculis quis risus sed, pulvinar mollis felis. Praesent consectetur molestie turpis eget finibus. Aenean vel sagittis purus. Curabitur non magna orci. Ut vitae odio lobortis, feugiat erat sit amet, lobortis ex. Nunc ut neque dolor. Phasellus non sodales ex, vel maximus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla convallis porta ex, nec eleifend purus laoreet ut.';
  static String terms_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vulputate, augue a condimentum cursus, sapien neque varius mi, eu tempor ex nulla nec diam. Donec augue augue, commodo et sagittis a, commodo sed urna. Nulla rutrum ante ac eleifend hendrerit. Pellentesque viverra elementum lorem non accumsan. Integer nec tortor eu lectus euismod euismod. Sed egestas libero vel mattis fermentum. Aliquam lacinia varius tristique. Ut at cursus velit. Morbi viverra ligula eu nunc auctor, scelerisque tincidunt velit ultricies. Pellentesque eleifend arcu ex, vitae finibus enim ullamcorper ac. Nam condimentum, tellus et dignissim tincidunt, libero ex dapibus ligula, pellentesque sodales libero lorem vitae orci.\n\nVivamus feugiat, felis vitae molestie maximus, dolor dolor mollis neque, nec auctor arcu ex ac elit. Aenean ac ante gravida, congue eros eu, imperdiet purus. Fusce vitae dui quis elit porttitor elementum vel at mi. Proin malesuada commodo pulvinar. Donec gravida ut est in sodales. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam feugiat purus in ligula pellentesque, vitae auctor justo eleifend.\n\nCurabitur fermentum, massa vitae maximus rhoncus, nunc justo tincidunt diam, sit amet lacinia justo dui sit amet tortor. Cras in purus nec purus accumsan ultricies. Nunc risus dolor, euismod sit amet sapien eu, consectetur rutrum metus. Suspendisse venenatis vitae mauris sed vulputate. Nullam mollis erat sed nunc accumsan, eu pellentesque dui sollicitudin. Quisque non tincidunt nibh. Proin et ex vel diam auctor vulputate. Proin interdum massa eget lectus consectetur, placerat elementum nisl auctor. Ut nec lectus cursus, dignissim enim vel, sollicitudin dui. Aliquam blandit, nunc sit amet pretium bibendum, diam orci venenatis tellus, a fringilla metus nunc vitae felis. Donec placerat lorem ut nisi vestibulum, cursus accumsan ligula consequat. Proin sit amet vestibulum nisi. Suspendisse id imperdiet felis, in luctus diam.\n\nNulla eu diam at sapien pretium aliquam. Integer euismod scelerisque arcu, sed blandit sapien rutrum et. Donec ultricies ligula erat, a venenatis mauris cursus sit amet. In dapibus laoreet enim eu tempus. Mauris commodo sed mi id tempor. Maecenas et velit odio. Donec tincidunt semper ipsum. Donec finibus pellentesque pulvinar. Duis volutpat sagittis dui, quis pretium nibh porta in. Ut condimentum, augue eget rhoncus maximus, nulla nibh euismod nunc, eu maximus mauris lorem nec felis. Donec et massa in leo efficitur maximus. Vestibulum tempus sed augue ac rhoncus. Quisque ut porttitor ipsum, in sagittis odio. Nunc tincidunt risus vel velit condimentum dapibus.\n\nSed lacus augue, iaculis quis risus sed, pulvinar mollis felis. Praesent consectetur molestie turpis eget finibus. Aenean vel sagittis purus. Curabitur non magna orci. Ut vitae odio lobortis, feugiat erat sit amet, lobortis ex. Nunc ut neque dolor. Phasellus non sodales ex, vel maximus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla convallis porta ex, nec eleifend purus laoreet ut.';
  static String privacy_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vulputate, augue a condimentum cursus, sapien neque varius mi, eu tempor ex nulla nec diam. Donec augue augue, commodo et sagittis a, commodo sed urna. Nulla rutrum ante ac eleifend hendrerit. Pellentesque viverra elementum lorem non accumsan. Integer nec tortor eu lectus euismod euismod. Sed egestas libero vel mattis fermentum. Aliquam lacinia varius tristique. Ut at cursus velit. Morbi viverra ligula eu nunc auctor, scelerisque tincidunt velit ultricies. Pellentesque eleifend arcu ex, vitae finibus enim ullamcorper ac. Nam condimentum, tellus et dignissim tincidunt, libero ex dapibus ligula, pellentesque sodales libero lorem vitae orci.\n\nVivamus feugiat, felis vitae molestie maximus, dolor dolor mollis neque, nec auctor arcu ex ac elit. Aenean ac ante gravida, congue eros eu, imperdiet purus. Fusce vitae dui quis elit porttitor elementum vel at mi. Proin malesuada commodo pulvinar. Donec gravida ut est in sodales. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam feugiat purus in ligula pellentesque, vitae auctor justo eleifend.\n\nCurabitur fermentum, massa vitae maximus rhoncus, nunc justo tincidunt diam, sit amet lacinia justo dui sit amet tortor. Cras in purus nec purus accumsan ultricies. Nunc risus dolor, euismod sit amet sapien eu, consectetur rutrum metus. Suspendisse venenatis vitae mauris sed vulputate. Nullam mollis erat sed nunc accumsan, eu pellentesque dui sollicitudin. Quisque non tincidunt nibh. Proin et ex vel diam auctor vulputate. Proin interdum massa eget lectus consectetur, placerat elementum nisl auctor. Ut nec lectus cursus, dignissim enim vel, sollicitudin dui. Aliquam blandit, nunc sit amet pretium bibendum, diam orci venenatis tellus, a fringilla metus nunc vitae felis. Donec placerat lorem ut nisi vestibulum, cursus accumsan ligula consequat. Proin sit amet vestibulum nisi. Suspendisse id imperdiet felis, in luctus diam.\n\nNulla eu diam at sapien pretium aliquam. Integer euismod scelerisque arcu, sed blandit sapien rutrum et. Donec ultricies ligula erat, a venenatis mauris cursus sit amet. In dapibus laoreet enim eu tempus. Mauris commodo sed mi id tempor. Maecenas et velit odio. Donec tincidunt semper ipsum. Donec finibus pellentesque pulvinar. Duis volutpat sagittis dui, quis pretium nibh porta in. Ut condimentum, augue eget rhoncus maximus, nulla nibh euismod nunc, eu maximus mauris lorem nec felis. Donec et massa in leo efficitur maximus. Vestibulum tempus sed augue ac rhoncus. Quisque ut porttitor ipsum, in sagittis odio. Nunc tincidunt risus vel velit condimentum dapibus.\n\nSed lacus augue, iaculis quis risus sed, pulvinar mollis felis. Praesent consectetur molestie turpis eget finibus. Aenean vel sagittis purus. Curabitur non magna orci. Ut vitae odio lobortis, feugiat erat sit amet, lobortis ex. Nunc ut neque dolor. Phasellus non sodales ex, vel maximus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla convallis porta ex, nec eleifend purus laoreet ut.';
  static String open_source_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vulputate, augue a condimentum cursus, sapien neque varius mi, eu tempor ex nulla nec diam. Donec augue augue, commodo et sagittis a, commodo sed urna. Nulla rutrum ante ac eleifend hendrerit. Pellentesque viverra elementum lorem non accumsan. Integer nec tortor eu lectus euismod euismod. Sed egestas libero vel mattis fermentum. Aliquam lacinia varius tristique. Ut at cursus velit. Morbi viverra ligula eu nunc auctor, scelerisque tincidunt velit ultricies. Pellentesque eleifend arcu ex, vitae finibus enim ullamcorper ac. Nam condimentum, tellus et dignissim tincidunt, libero ex dapibus ligula, pellentesque sodales libero lorem vitae orci.\n\nVivamus feugiat, felis vitae molestie maximus, dolor dolor mollis neque, nec auctor arcu ex ac elit. Aenean ac ante gravida, congue eros eu, imperdiet purus. Fusce vitae dui quis elit porttitor elementum vel at mi. Proin malesuada commodo pulvinar. Donec gravida ut est in sodales. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam feugiat purus in ligula pellentesque, vitae auctor justo eleifend.\n\nCurabitur fermentum, massa vitae maximus rhoncus, nunc justo tincidunt diam, sit amet lacinia justo dui sit amet tortor. Cras in purus nec purus accumsan ultricies. Nunc risus dolor, euismod sit amet sapien eu, consectetur rutrum metus. Suspendisse venenatis vitae mauris sed vulputate. Nullam mollis erat sed nunc accumsan, eu pellentesque dui sollicitudin. Quisque non tincidunt nibh. Proin et ex vel diam auctor vulputate. Proin interdum massa eget lectus consectetur, placerat elementum nisl auctor. Ut nec lectus cursus, dignissim enim vel, sollicitudin dui. Aliquam blandit, nunc sit amet pretium bibendum, diam orci venenatis tellus, a fringilla metus nunc vitae felis. Donec placerat lorem ut nisi vestibulum, cursus accumsan ligula consequat. Proin sit amet vestibulum nisi. Suspendisse id imperdiet felis, in luctus diam.\n\nNulla eu diam at sapien pretium aliquam. Integer euismod scelerisque arcu, sed blandit sapien rutrum et. Donec ultricies ligula erat, a venenatis mauris cursus sit amet. In dapibus laoreet enim eu tempus. Mauris commodo sed mi id tempor. Maecenas et velit odio. Donec tincidunt semper ipsum. Donec finibus pellentesque pulvinar. Duis volutpat sagittis dui, quis pretium nibh porta in. Ut condimentum, augue eget rhoncus maximus, nulla nibh euismod nunc, eu maximus mauris lorem nec felis. Donec et massa in leo efficitur maximus. Vestibulum tempus sed augue ac rhoncus. Quisque ut porttitor ipsum, in sagittis odio. Nunc tincidunt risus vel velit condimentum dapibus.\n\nSed lacus augue, iaculis quis risus sed, pulvinar mollis felis. Praesent consectetur molestie turpis eget finibus. Aenean vel sagittis purus. Curabitur non magna orci. Ut vitae odio lobortis, feugiat erat sit amet, lobortis ex. Nunc ut neque dolor. Phasellus non sodales ex, vel maximus odio. Interdum et malesuada fames ac ante ipsum primis in faucibus. Nulla convallis porta ex, nec eleifend purus laoreet ut.';

  static String IMAGES_BASE_PATH = "assets/img/";
  static String IMAGE_SPLASH = IMAGES_BASE_PATH + "splash_logo.jpg";
  static String IMAGE_WELCOME = IMAGES_BASE_PATH + "welcome_img.jpg";
  static String IMAGE_INTRO = IMAGES_BASE_PATH + "intro_img.jpg";
  static String IMAGE_GOAL = IMAGES_BASE_PATH + "goal_img.jpg";

  static double getHeight(BuildContext _context, double percent) {
    // print("==1=="+MediaQuery.of(_context).size.height.toString());
    HEADER_HEIGHT = (MediaQuery.of(_context).size.height * percent);
    // print("==2=="+HEADER_HEIGHT.toString());
    return HEADER_HEIGHT;
  }

  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.85),
          child: CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }

  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  static String limitString(String text,
      {int limit = 24, String hiddenText = "..."}) {
    return text.substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? hiddenText : '');
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: S.of(context).tapBackAgainToLeave);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

}
