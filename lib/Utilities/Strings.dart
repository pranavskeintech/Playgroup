import 'package:flutter/material.dart';
import 'package:playgroup/Models/CommentsRes.dart';

mixin Strings {
  static bool availConfirm = false;

  static bool activityConfirmed = false;

  static String authToken = '';

  static String refreshToken = '';

  static bool internetDialog = false;

  static var appThemecolor = const Color.fromRGBO(94, 37, 108, 1);

  static var textFeildBg = const Color.fromRGBO(245, 245, 245, 1);

  static var textFeildHeading = const Color.fromRGBO(187, 185, 185, 1);

  static var chipsbg = const Color.fromRGBO(241, 244, 251, 1);

  static String appName = 'Play Group';

  static String imageUrl = "https://demo.emeetify.com:5890/";

  // static String socketUrl = 'http://192.168.1.108:6253/';
  static String socketUrl = 'https://demo.emeetify.com:6253/';

  static String IndChat =
      'https://demo.emeetify.com:5890/chat/individual_chat/';

  static String GroupChat = 'https://demo.emeetify.com:5890/chat/Group_chat/';

  static String MarkChat =
      'https://demo.emeetify.com:5890/chat/markavail_chat/';

  static String parentName = '';
  static String parentemail = '';

  static bool firstLogin = true;
  static bool ForgotPassword = false;

  static String fcmToken = '';

  static double Latt = 0;

  static double Long = 0;

  static String UserName = '';

  static String EmailId = '';

  static String Password = '';

  static String PhoneNumber = '';

  static String? Location = '';

  static int Parent_Id = 0;

  static var editIndex = 0;

  static String searchText = "";

  static bool profilepage = false;

  static bool DashboardPage = false;

  static String markAvailabiltydate = "";

  static String markAvailabiltystartTime = "";

  static String markAvailabiltyendTime = "";

  static String markAvailabiltydesc = "";

  static String markAvailabiltylocations = "";

  static int? markAvailabiltycategory;
  static List<CommentRes> comments = [];

  static int? markAvailabiltyTopic;

  static bool FriendNotification = false;

  static int SelectedChild = 0;

  static String? ProfilePic = '';

  static int? selectedAvailability;

  static bool fromProfile = false;

  static int ChoosedChild = 0;

  static int notifictionCount = 0;

  static int CoParent=0;
}
