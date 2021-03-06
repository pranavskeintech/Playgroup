import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:playgroup/Models/AcceptFriendRequestReq.dart';
import 'package:playgroup/Models/AcceptFriendRequestReq.dart';
import 'package:playgroup/Models/AcceptedFriendsRes.dart';
import 'package:playgroup/Models/AddChildReq.dart';
import 'package:playgroup/Models/AddChildReq2.dart';
import 'package:playgroup/Models/AddcoParentReq.dart';
import 'package:playgroup/Models/AvailPauseReq.dart';
import 'package:playgroup/Models/AvailabityRes.dart';
import 'package:playgroup/Models/CheckchildRes.dart';
import 'package:playgroup/Models/ChooseChildReq.dart';
import 'package:playgroup/Models/CommonReq.dart';
import 'package:playgroup/Models/CreateGroupReq.dart';
import 'package:playgroup/Models/CreateGroupRes.dart';
import 'package:playgroup/Models/EditAvailabilityCommonReq.dart';
import 'package:playgroup/Models/EditAvailabilityReq.dart';
import 'package:playgroup/Models/EditChildReq.dart';
import 'package:playgroup/Models/FriendRequestReq.dart';
import 'package:playgroup/Models/FriendsAndGroups.dart';
import 'package:playgroup/Models/GetActivitiesRes.dart';
import 'package:playgroup/Models/GetAllActivities.dart';
import 'package:playgroup/Models/GetAllGroupDetails.dart';
import 'package:playgroup/Models/GetChatsList.dart';
import 'package:playgroup/Models/GetChildProfile.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Models/GetGroupDetailsByIdRes.dart';
import 'package:playgroup/Models/GetInterestsRes.dart';
import 'package:playgroup/Models/GetMarkAvailabilityListRes.dart';
import 'package:playgroup/Models/GetNotificationList.dart';
import 'package:playgroup/Models/GetOtherMarkAvailabilityRes.dart';
import 'package:playgroup/Models/GetProfileRes.dart';
import 'package:playgroup/Models/GetSportsRes.dart';
import 'package:playgroup/Models/Get_CityRes.dart';
import 'package:playgroup/Models/JoinfriendsReq.dart';
import 'package:playgroup/Models/LoginReq.dart';
import 'package:playgroup/Models/LoginRes.dart';
import 'package:playgroup/Models/MarkAvailabilityReq.dart';
import 'package:playgroup/Models/OtherChildRes.dart';
import 'package:playgroup/Models/OwnAvailabilityDetailsRes.dart';
import 'package:playgroup/Models/PastActivitiesRes.dart';
import 'package:playgroup/Models/PastActivityById.dart';
import 'package:playgroup/Models/PendingFriendReqRes.dart';
import 'package:playgroup/Models/RegisterReq.dart';
import 'package:playgroup/Models/Register_Res.dart';
import 'package:playgroup/Models/RemoveParticipantsReq.dart';
import 'package:playgroup/Models/SearchResultRes.dart';
import 'package:playgroup/Models/SuggestTimeReq.dart';
import 'package:playgroup/Models/UserDetailsRes.dart';
import 'package:playgroup/Models/addGroupParticipants.dart';
import 'package:playgroup/Models/blockFriendReq.dart';
import 'package:playgroup/Models/editChildInterests.dart';
import 'package:playgroup/Models/editChildLanguage.dart';
import 'package:playgroup/Models/getPastActPhotos.dart';
import 'package:playgroup/Models/getPastActPhotos.dart';
import 'package:playgroup/Models/reportUserReq.dart';
import 'package:playgroup/Models/updateGroupReq.dart';
import 'package:playgroup/Models/uploadAudio.dart';
import 'package:playgroup/Models/uploadAvailChatAudio.dart';
import 'package:playgroup/Models/uploadGroupChatAudio.dart';
import 'package:playgroup/Models/uploadPastActPhotos.dart';
import 'package:playgroup/Screens/EditChildInterests.dart';
import 'package:playgroup/Screens/deviceIdReq.dart';
import 'package:playgroup/Utilities/AppUtlis.dart';
import 'package:playgroup/Utilities/Functions.dart';
import 'package:playgroup/Screens/SplashScreen.dart';
import 'package:playgroup/main.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:playgroup/Models/CommonRes.dart';

import '../Utilities/Strings.dart';
part 'ApiService.g.dart';

// Run this code in termial to generate ApiService.g.dart file
//flutter packages pub run build_runner watch --delete-conflicting-outputs

//@RestApi(baseUrl: 'http://3.109.217.67:80/sss/')
//@RestApi(baseUrl: 'http://192.168.1.108:5899/playgroup/')
// @RestApi(baseUrl: 'http://172.16.200.70:3445/sss/')
@RestApi(baseUrl: 'https://demo.emeetify.com:81/playgroup/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("user/")
  Future<LoginRes> login(@Body() LoginReq body);

  @POST("user/register")
  Future<Register_Res> Register(@Body() UserRegisterReq body);

  @POST("user/forgot_pswd")
  Future<Register_Res> ForgotPassword(@Body() UserRegisterReq body);

  @POST("mark/addmark")
  Future<CommonRes> createAvailability(@Body() MarkAvailabilityReq body);

  @PUT("mark/updatemark")
  Future<CommonRes> EditAvailability(@Body() EditAvailabilityCommonReq body);

  @PUT("user/updatefcm")
  Future<CommonRes> updateFCM(@Body() deviceIdReq body);

  @POST("user/coparent")
  Future<CommonRes> addCoParent(@Body() AddcoParentReq body);

  @GET("user/Checkchild/{name}")
  Future<CheckchildRes> Checkchild(
      @Path("name") String name, @Path("user_id") int id);

  @GET("user/searchchild/{child_id}/{name}")
  Future<SearchresultRes> SearchChild(
      @Path("name") String name, @Path("child_id") int id);

  @GET("user/get_City/IN/TN")
  Future<GetCity> Get_City();

  @GET("user/check/{EmailOrPhone_No}/null")
  Future<CommonRes> CheckUser(@Path("EmailOrPhone_No") String EmailOrPhoneNo);

  @GET("user/check/{EmailOrPhone_No}/Google")
  Future<LoginRes> GoogleLogin(@Path("EmailOrPhone_No") String EmailOrPhoneNo);

  @GET("user/check/{EmailOrPhone_No}/Facebook")
  Future<LoginRes> FBLogin(@Path("EmailOrPhone_No") String EmailOrPhoneNo);

  @POST("user/addchild")
  Future<CommonRes> AddChild(@Body() AddChildReq body);

  @POST("friends")
  Future<CommonRes> sendFriendRequest(@Body() FriendRequestReq body);

  @DELETE("friends/{user_id}/{otherChild_id}")
  Future<CommonRes> deleteFriendRequest(
      @Path("user_id") int ChildID, @Path("otherChild_id") int otherChildID);

  @DELETE("comment/deletelike/{child_id}/{markavail_id}")
  Future<CommonRes> unLike(
      @Path("child_id") int ChildID, @Path("markavail_id") int markavailId);

  @POST("user/addchild")
  Future<CommonRes> AddChild2(@Body() AddChildReq2 body);

  @GET("user/getparent/{ChildID}")
  Future<UserDetailsRes> getParentsDetails(@Path("ChildID") int ChildID);

  @GET("user/getchildid/{child_id}")
  Future<GetChildProfileRes> getchildProfile(@Path("child_id") int ChildID);

  @GET("user/checkfriendsbyid/{child_id}/{otherChild_id}")
  Future<OtherChildRes> getOtherchildDetails(
      @Path("child_id") int ChildID, @Path("otherChild_id") int otherChild_id);

  @GET("user/getchild")
  Future<GetChildRes> GetChild();

  @DELETE("user/child/{ChildID}")
  Future<GetChildRes> DeleteChild(@Path("ChildID") int ChildID);

  @POST("user/changeAccess/{access}")
  Future<CommonRes> updateAccess(@Path("access") String access);

  @DELETE("mark/deletemark/{avail_id}")
  Future<CommonRes> deleteAvailability(@Path("avail_id") int availID);

  @DELETE("user/coparent")
  Future<CommonRes> deleteCoParent();

  @PUT("mark/pausemark")
  Future<CommonRes> pauseAvailability(@Body() AvailPauseReq body);

  @PUT("user/editchild")
  Future<CommonRes> EditChild(@Body() EditChildReq body);

  @PUT("user/editlanguage")
  Future<CommonRes> editChildLanguages(@Body() editChildLanguage body);

  @PUT("user/editinterest")
  Future<CommonRes> EditChildInterest(@Body() editChildInt body);

  @PUT("user/updatechild")
  Future<CommonRes> ChooseChild(@Body() ChooseChildReq body);

  @PUT("user/updateParent")
  Future<CommonRes> updateParent(@Body() UserRegisterReq body);

  @GET("user/profile")
  Future<GetProfileRes> GetProfile();

  @GET("mark/getactivities")
  Future<GetActivitiesRes> GetActivities();

  @GET("mark/get_all_activites/{ChildID}")
  Future<GetAllActivities> GetAllActivity(@Path("ChildID") int ChildID);

  @GET("mark/getsports/{SportID}")
  Future<GetSportsRes> GetSports(@Path("SportID") int sprotID);

  @GET("user/getinterest/{ChildID}")
  Future<GetInterestsRes> GetInterests(@Path("ChildID") int ChildID);

  @GET("/mark/getmarkbyid/{availability_id}/{ChildID}")
  Future<OwnAvailabilityDetailsRes> getAvailabilityDetails(
      @Path("availability_id") int availability_id,
      @Path("ChildID") int ChildID);

  @GET("friends/{ChildID}/Pending")
  Future<PendingFriendReqRes> GetPendingFriendReq(@Path("ChildID") int ChildID);

  @POST("user/blockmails")
  Future<CommonRes> BlockFriends(@Body() blockFriend body);

  @POST("user/report")
  Future<CommonRes> ReportUser(@Body() reportUser body);

  @GET("friends/{ChildID}/Accepted")
  Future<PendingFriendReqRes> getFriends(@Path("ChildID") int ChildID);
  @PUT("friends/")
  Future<CommonRes> AcceptFriendRequest(@Body() AcceptFriendReq body);

  @DELETE("friends/{ChildID}/{child_friend_id}")
  Future<CommonRes> CancelFriendReq(@Path("ChildID") int ChildID,
      @Path("child_friend_id") int child_friend_id);

  @GET("friends/{ChildID}/Accepted")
  Future<AcceptedFriendsRes> GetAcceptedFriendReq(@Path("ChildID") int ChildID);

  @GET("mark/getmark/{ChildID}")
  Future<GetAllActivities> GetMarkAvailability(@Path("ChildID") int ChildID);

  @GET("mark/join_markavail_list/{ChildID}")
  Future<OtherMarkAvailabilityRes> GetOtherMarkAvailability(
      @Path("ChildID") int ChildID);

  @PUT("mark/joinfriends")
  Future<CommonRes> JoinFriendsMarkAvailability(@Body() JoinfriendsReq body);

  @POST("mark/suggesttime")
  Future<CommonRes> suggestTime(@Body() SuggestTimeReq body);

  @PUT("/user/updateCoParent")
  Future<CommonRes> updateCoParent(@Body() AddcoParentReq body);

  @GET("user/notification_list/{ChildID}")
  Future<GetNotificationListRes> GetNotificationList(
      @Path("ChildID") int ChildID);

  @PUT("user/update_notification_status")
  Future<CommonRes> updateNotificationstatus(@Body() CommonReq body);

///////////  Groups /////////////////
  @POST("groups/create/{ChildID}")
  Future<CreateGroupRes> CreateGroup(
      @Body() CreateGroupReq body, @Path("ChildID") int ChildID);

  @PUT("groups/update/{groupId}")
  Future<CommonRes> updateGroup(
      @Body() updateGroupReq body, @Path("groupId") int groupId);

  @GET("groups/getDetails/{groupId}")
  Future<GetGroupDetailsByIdRes> GetGroupDetailsbyId(
      @Path("groupId") int groupId);

  @GET("groups/getAll/{ChildID}")
  Future<GetAllGroupDetailsRes> GetAllGroupDetails(
      @Path("ChildID") int ChildID);

  @GET("groups/all/{ChildID}")
  Future<GroupsAndFriends> GetGroupFriends(@Path("ChildID") int ChildID);

  @POST("groups/add_participants/{groupId}")
  Future<CommonRes> addParticipantsGroup(
      @Body() addGroupParticipants body, @Path("groupId") int groupId);

  @DELETE("groups/exitGroup/{groupId}/{ChildID}")
  Future<CommonRes> exitGroup(
      @Path("groupId") int groupId, @Path("ChildID") int ChildID);

  @DELETE("groups/remove_participants/{ChildID}")
  Future<CommonRes> removeParticipantsGroup(
      @Body() RemoveParticipantsGroupReq body, @Path("ChildID") int ChildID);

///////////  Past Activites /////////////////

  @GET("mark/get_past_mark/{ChildID}")
  Future<PastActivitiesRes> PastActivities(@Path("ChildID") int ChildID);

  @GET("mark/get_past_markbyid/{markavailId}/{ChildID}")
  Future<PastActivityByIdRes> PastActivityById(
      @Path("markavailId") int markavailId, @Path("ChildID") int ChildID);

  @GET("mark/get_past_images/{markavailId}/{ChildID}")
  Future<getPastActPhotos> getPastActPhoto(
      @Path("markavailId") int markavailId, @Path("ChildID") int ChildID);

  @POST("mark/add_past_photos")
  Future<CommonRes> uploadPastActPhoto(@Body() uploadPastActPhotos body);

  @POST("comment/addlike")
  Future<CommonRes> addLike(@Body() CommonReq body);

  @DELETE("mark/delete_past_images/{pastActivitiesImagesId}")
  Future<CommonRes> DeletePastImgs(
      @Path("pastActivitiesImagesId") int pastActivitiesImagesId);

//////////////  Chats List /////////////////

  @GET("chat/getchat_list/{ChildID}")
  Future<GetChatsList> GetChatList(@Path("ChildID") int ChildID);

  @POST("chat/upload_chat_audio")
  Future<CommonRes> uploadIndChatVoice(@Body() uploadIndChatAudio body);

  @POST("chat/upload_chat_audio")
  Future<CommonRes> uploadGroupChatVoice(@Body() uploadGroupChatAudio body);
  
  @POST("chat/upload_chat_audio")
  Future<CommonRes> uploadAvailChatVoice(@Body() uploadAvailChatAudio body);

/////////////////////////////////////
////////////////////////////////////////////////////////
  /// Request and Response Body
//////////////////////////////////////////////////////////////////////////////////////////

  static ApiService create() {
    final dio = Dio();
    try {
      print("check");
      dio.interceptors.add(PrettyDioLogger());
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers["Content-Type"] = "application/json";
        options.headers["jwt"] = Strings.authToken;
        options.headers["refresh-token"] = Strings.refreshToken;
        options.followRedirects = false;
        options.validateStatus = (status) {
          if (status == 403) {
            AppUtils.showToast(
                "Session has been expired! Please login again", context);
            navigatorKey.currentState?.pushNamed('/Login');
          }
          return status! < 500;
        };
        return handler.next(options);
      }));

      return ApiService(dio);
    } on DioError catch (error) {
      print("DioError");
      print(error);
      print(error.error);
      return ApiService(dio);
    }
  }
}
