import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;
//import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:playgroup/Models/CommentsRes.dart';
import 'package:playgroup/Network/ApiService.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Strings.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dart_emoji/dart_emoji.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

int? MarkAvailabilityId;
String? Profile;
String? CategoryName;
String? ActivityName;
String? ChildName;

var initialCommentCheck = true;
AnimationController? _animationController;
IO.Socket? _socket;
List<String> docImg = [];

class Comments extends StatefulWidget {
  static const String routeName = "/comments";
  int? markAvailId;
  String? profile;
  String? categoryName;
  String? activityName;
  String? childName;

  Comments(
      {Key? key,
      @required this.markAvailId,
      @required this.profile,
      @required this.categoryName,
      @required this.activityName,
      @required this.childName})
      : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool isShowSticker = false;
  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    MarkAvailabilityId = widget.markAvailId;
    Profile = widget.profile;
    ActivityName = widget.activityName;
    CategoryName = widget.categoryName;
    ChildName = widget.childName;
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text("Comments"),
            backgroundColor: Strings.appThemecolor,
          ),
          // backgroundColor: Colors.grey[300],
          body: WillPopScope(
              child: CommentsContent(),
              onWillPop: () {
                Navigator.pop(context);
                _socket?.disconnect();
                _socket?.dispose();
                throw 'Screen Change';
              }),
        ));
  }
}

class CommentsContent extends StatefulWidget {
  static const String routeName = "/comments";

  @override
  _CommentsContentState createState() => _CommentsContentState();
}

class _CommentsContentState extends State<CommentsContent>
    with SingleTickerProviderStateMixin {
  var _currDoc;
  TextEditingController _msgcontroller = TextEditingController();
  //ScrollController _scrollController = new ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  FocusNode msgField = new FocusNode();

  String? filepath;
  int? projectId;

  var _key;

  String? projectname;

  var emojiRegexp =
      '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';

  var parser = EmojiParser();

  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    // getUserCats();
    // getuserCatgories();
    // getProjectDetails();

    print("initial value check-->> $initialCommentCheck");
    initialCommentCheck = true;

    print("init state variable assigned--> $initialCommentCheck");
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animationController?.repeat(reverse: true);

    print("Mark avail id--> $MarkAvailabilityId");
    print("id:${Strings.SelectedChild}");
    // getUserCats();
    //Strings.socketUrl
    _socket = IO.io("http://demo.emeetify.com:6252/", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {
        'token': Strings.authToken,
        'markavail_id': MarkAvailabilityId,
        'child_id': Strings.SelectedChild,
        'mark_type': "comments",
        'forceNew': false,
      }
    });
    _socket?.connect();
    _socket?.onConnect((_) {
      print('connect');
    });
    print("connection established");
    _socket?.on("connect", (_) {
      print('Connected');
      print("Calling function");
      getComments();
    });
  }

  @override
  void dispose() {
    _animationController?.dispose();

    _socket?.disconnect();
    _socket?.dispose();
    super.dispose();

    print("dispose variable assigned--> $initialCommentCheck");
    // Strings.comments = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Listener(
        onPointerUp: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)))
            : Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadiusDirectional.circular(10)),
                        height: 80,
                        // width: MediaQuery.of(context).size.width * 0.9,
                        child: ListTile(
                          isThreeLine: true,
                          leading:
                              //  CircleAvatar(
                              //   backgroundImage: AssetImage("assets/imgs/child.jpg"),
                              // ),
                              CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: (Profile != "null")
                                ? NetworkImage(Strings.imageUrl + Profile!)
                                : AssetImage("assets/imgs/profile-user.png")
                                    as ImageProvider,
                          ),
                          title: Text(ChildName ?? ""),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    CategoryName!,
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 1,
                                    height: 1,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        ActivityName!,
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Strings.comments.length > 0
                        ? Expanded(
                            child: ScrollablePositionedList.builder(
                                shrinkWrap: true,
                                reverse: true,
                                itemScrollController: itemScrollController,
                                itemPositionsListener: itemPositionsListener,
                                itemCount: Strings.comments.length,
                                padding: EdgeInsets.all(20),
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Strings.comments[index].childId ==
                                          Strings.SelectedChild
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _showMyDialog(
                                                            context,
                                                            Strings.imageUrl +
                                                                Strings
                                                                    .comments[
                                                                        index]
                                                                    .profile!);
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 12,
                                                        backgroundImage: Strings
                                                                    .comments[
                                                                        index]
                                                                    .profile !=
                                                                null
                                                            ? NetworkImage(Strings
                                                                    .imageUrl +
                                                                (Strings
                                                                    .comments[
                                                                        index]
                                                                    .profile!))
                                                            : AssetImage(
                                                                    "assets/icons/account.png")
                                                                as ImageProvider,
                                                        backgroundColor: Colors
                                                            .grey
                                                            .withOpacity(0.3),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  (Strings.SelectedChild ==
                                                                          Strings
                                                                              .comments[
                                                                                  index]
                                                                              .childId!)
                                                                      ? "You"
                                                                      : Strings
                                                                              .comments[
                                                                                  index]
                                                                              .childName! +
                                                                          " . ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                              Container(
                                                                width: 18.0,
                                                                height: 18.0,
                                                                child:
                                                                    IconButton(
                                                                  padding:
                                                                      new EdgeInsets
                                                                              .all(
                                                                          0.0),
                                                                  color: Colors
                                                                      .grey,
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .update,
                                                                      size:
                                                                          18.0),
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Text(
                                                                  calculateTimeDifferenceBetween(
                                                                      serverDate: Strings
                                                                          .comments[
                                                                              index]
                                                                          .createdAt),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          600],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                              Spacer(),
                                                              (Strings.SelectedChild ==
                                                                      Strings
                                                                          .comments[
                                                                              index]
                                                                          .childId!)
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 20),
                                                                          child: InkWell(
                                                                              onTap: () {
                                                                                deleteComments(Strings.comments[index].commetId);
                                                                              },
                                                                              child: ImageIcon(
                                                                                AssetImage("assets/imgs/delete_1.png"),
                                                                                color: Colors.blue,
                                                                                size: 18,
                                                                              )),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : SizedBox(),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 12,
                                                          ),
                                                          SizedBox(height: 10),
                                                          Container(
                                                            child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      parser.emojify(Strings
                                                                          .comments[
                                                                              index]
                                                                          .comment!),
                                                                    ),
                                                                  ],
                                                                )),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.75,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                    BorderRadiusDirectional
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              MySeparator(
                                                color: Colors.grey[500]!,
                                              )
                                            ],
                                          ))
                                      // Slidable(
                                      //   key: UniqueKey(),
                                      //   endActionPane: ActionPane(
                                      //     // A motion is a widget used to control how the pane animates.
                                      //     motion: const ScrollMotion(),

                                      //     // A pane can dismiss the Slidable.
                                      //     dismissible:
                                      //         DismissiblePane(onDismissed: () {}),

                                      //     // All actions are defined in the children parameter.
                                      //     children: [
                                      //       // A SlidableAction can have an icon and/or a label.
                                      //       SlidableAction(
                                      //         onPressed: (dt) {
                                      //           print("delete");
                                      //           deleteComments(
                                      //               Strings.comments[index].commetId);
                                      //         },
                                      //         backgroundColor: Colors.transparent,
                                      //         foregroundColor: Colors.black,
                                      //         icon: Icons.delete,
                                      //         label: 'Delete',
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   child: Padding(
                                      //       padding: EdgeInsets.symmetric(vertical: 10),
                                      //       child: Column(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.start,
                                      //         children: [
                                      //           Row(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               GestureDetector(
                                      //                 onTap: () {
                                      //                   _showMyDialog(
                                      //                       context,
                                      //                       Strings.imageUrl +
                                      //                           Strings.comments[index]
                                      //                               .profile!);
                                      //                 },
                                      //                 child: CircleAvatar(
                                      //                   radius: 12,
                                      //                   backgroundImage: Strings
                                      //                               .comments[index]
                                      //                               .profile !=
                                      //                           null
                                      //                       ? NetworkImage(
                                      //                           Strings.imageUrl +
                                      //                               (Strings
                                      //                                   .comments[index]
                                      //                                   .profile!))
                                      //                       : AssetImage(
                                      //                               "assets/icons/account.png")
                                      //                           as ImageProvider,
                                      //                   backgroundColor: Colors.grey
                                      //                       .withOpacity(0.3),
                                      //                 ),
                                      //               ),
                                      //               SizedBox(
                                      //                 width: 10,
                                      //               ),
                                      //               Column(
                                      //                 crossAxisAlignment:
                                      //                     CrossAxisAlignment.start,
                                      //                 children: [
                                      //                   Row(
                                      //                     crossAxisAlignment:
                                      //                         CrossAxisAlignment.end,
                                      //                     children: [
                                      //                       Text(
                                      //                           (Strings.SelectedChild ==
                                      //                                   Strings
                                      //                                       .comments[
                                      //                                           index]
                                      //                                       .childId!)
                                      //                               ? "You"
                                      //                               : Strings
                                      //                                       .comments[
                                      //                                           index]
                                      //                                       .childName! +
                                      //                                   " . ",
                                      //                           style: TextStyle(
                                      //                               color: Colors.black,
                                      //                               fontWeight:
                                      //                                   FontWeight
                                      //                                       .w600)),
                                      //                       Container(
                                      //                         width: 18.0,
                                      //                         height: 18.0,
                                      //                         child: IconButton(
                                      //                           padding:
                                      //                               new EdgeInsets.all(
                                      //                                   0.0),
                                      //                           color: Colors.grey,
                                      //                           icon: new Icon(
                                      //                               Icons.update,
                                      //                               size: 18.0),
                                      //                           onPressed: () {},
                                      //                         ),
                                      //                       ),
                                      //                       SizedBox(
                                      //                         width: 1,
                                      //                       ),
                                      //                       Text(
                                      //                           calculateTimeDifferenceBetween(
                                      //                               serverDate: Strings
                                      //                                   .comments[index]
                                      //                                   .createdAt),
                                      //                           style: TextStyle(
                                      //                               color: Colors
                                      //                                   .grey[600],
                                      //                               fontWeight:
                                      //                                   FontWeight
                                      //                                       .w500)),
                                      //                     ],
                                      //                   ),
                                      //                   SizedBox(
                                      //                     height: 12,
                                      //                   ),
                                      //                   SizedBox(height: 10),
                                      //                   Container(
                                      //                     child: Padding(
                                      //                         padding:
                                      //                             EdgeInsets.all(10),
                                      //                         child: Column(
                                      //                           crossAxisAlignment:
                                      //                               CrossAxisAlignment
                                      //                                   .start,
                                      //                           children: [
                                      //                             Text(
                                      //                               Strings
                                      //                                   .comments[index]
                                      //                                   .comment
                                      //                                   .toString(),
                                      //                             ),
                                      //                           ],
                                      //                         )),
                                      //                     width: MediaQuery.of(context)
                                      //                             .size
                                      //                             .width *
                                      //                         0.75,
                                      //                     decoration: BoxDecoration(
                                      //                         color: Colors.transparent,
                                      //                         borderRadius:
                                      //                             BorderRadiusDirectional
                                      //                                 .circular(5)),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ],
                                      //           ),
                                      //           SizedBox(
                                      //             height: 20,
                                      //           ),
                                      //           MySeparator(
                                      //             color: Colors.grey[500]!,
                                      //           )
                                      //         ],
                                      //       )),
                                      // )
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _showMyDialog(
                                                          context,
                                                          Strings.imageUrl +
                                                              Strings
                                                                  .comments[
                                                                      index]
                                                                  .profile!);
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundImage: Strings
                                                                  .comments[
                                                                      index]
                                                                  .profile !=
                                                              null
                                                          ? NetworkImage(Strings
                                                                  .imageUrl +
                                                              (Strings
                                                                  .comments[
                                                                      index]
                                                                  .profile!))
                                                          : AssetImage(
                                                                  "assets/icons/account.png")
                                                              as ImageProvider,
                                                      backgroundColor: Colors
                                                          .grey
                                                          .withOpacity(0.3),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              Strings
                                                                      .comments[
                                                                          index]
                                                                      .childName! +
                                                                  " . ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Container(
                                                            width: 18.0,
                                                            height: 18.0,
                                                            child: IconButton(
                                                              padding:
                                                                  new EdgeInsets
                                                                      .all(0.0),
                                                              color:
                                                                  Colors.grey,
                                                              icon: new Icon(
                                                                  Icons.update,
                                                                  size: 18.0),
                                                              onPressed: () {},
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 1,
                                                          ),
                                                          Text(
                                                              calculateTimeDifferenceBetween(
                                                                  serverDate: Strings
                                                                      .comments[
                                                                          index]
                                                                      .createdAt),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  parser.emojify(Strings
                                                                      .comments[
                                                                          index]
                                                                      .comment!),
                                                                ),
                                                              ],
                                                            )),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.75,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadiusDirectional
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              MySeparator(
                                                color: Colors.grey[500]!,
                                              )
                                            ],
                                          ));
                                }),
                          )
                        : Expanded(
                            child: Center(
                              child: Text("No comments found!"),
                            ),
                          ),
                    Strings.comments.length == 0 ? Spacer() : SizedBox(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding:
                              EdgeInsets.only(left: 10, bottom: 10, top: 10),
                          height: 50,
                          width: double.infinity,
                          // color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: TextField(
                                    // inputFormatters: [
                                    //   FilteringTextInputFormatter.allow(
                                    //     RegExp(emojiRegexp+"[a-zA-Z]"),
                                    //   ),
                                    // ],
                                    controller: _msgcontroller,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                          bottom: 15.0,
                                        ),
                                        hintText: "Type your Comment...",
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontStyle: FontStyle.italic),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  postComments();
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                backgroundColor: Strings.appThemecolor,
                                elevation: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  getComments() async {
    print("Getting comments");
    _socket?.on("get-comments", (_data) {
      print('fromServer');

      log('fromServer comments $_data');
      setState(() {
        print("Dta chacek--> $initialCommentCheck");
        print("getting inside");
        msgField.unfocus();

        if (_data.toString() == '[]') {
          Strings.comments = [];
          _isLoading = false;
        } else {
          if (_data![0]['markavail_id'] == MarkAvailabilityId) {
            Strings.comments = [];
            for (var item in _data) {
              Strings.comments.add(CommentRes.fromJson(item));
              print("set state");
            }
            _isLoading = false;
          }
        }
        initialCommentCheck = false;
        print("Comments fetched changing to false");

        // itemScrollController.jumpTo(index:0);
        msgField.unfocus();

        //  });
      });
    });
  }

  postComments() async {
    // print(json.encode(tagedUsersId.toString()));
    if (_msgcontroller.text.trim() == "") {
      AppUtils.showError(context, "Kindly add some text!", '');
    } else {
      print("emoji:${_msgcontroller.text}");

      print(parser.unemojify(_msgcontroller.text));
      _socket?.emitWithAck(
          'create-comment',
          json.encode({
            "comment": parser.unemojify(_msgcontroller.text),
            "markavail_id": MarkAvailabilityId,
            "child_id": Strings.SelectedChild
          }), ack: (data) {
        print('ack $data');
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });

      _msgcontroller.text = '';

      msgField.unfocus();
    }
  }

  deleteComments(commentId) async {
    print("deleting");
    print(commentId);
    _socket?.emitWithAck('delete-comment', commentId, ack: (data) {
      print('ack $data');
      if (data != null) {
        print('from server $data');
      } else {
        print("Null");
      }
    });
  }

  static String calculateTimeDifferenceBetween({@required String? serverDate}) {
    DateTime startDate = DateTime.parse(serverDate!);
    //print(DateFormat.MMMEd().format(startDate));
    DateTime endDate = DateTime.now();

    // var dateUtc = DateTime.now().toUtc();
    // var strToDateTime = DateTime.parse(dateUtc.toString());
    // final convertLocal = strToDateTime.toLocal();
    // var newFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
    // String updatedDt = newFormat.format(convertLocal);
    // print(dateUtc);
    // print(convertLocal);
    // print(updatedDt);

    int seconds = endDate.difference(startDate).inSeconds;
    if (seconds < 60)
      return '${seconds.abs()} second ago';
    else if (seconds >= 60 && seconds < 3600)
      return '${startDate.difference(endDate).inMinutes.abs()} minute ago';
    else if (seconds >= 3600 && seconds < 86400)
      return '${startDate.difference(endDate).inHours.abs()} hour ago';
    else
      return '${startDate.difference(endDate).inDays.abs()} day ago';
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

Future<void> _showMyDialog(context, imgurl) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    new Icon(Icons.close, size: 22.0, color: Colors.black),
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  image: new DecorationImage(
                    image: new NetworkImage(imgurl),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                ),
              )),
        ),
      );
    },
  );
}
