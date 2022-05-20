import 'package:dio/dio.dart';
import 'package:playgroup/Models/AddChildReq.dart';
import 'package:playgroup/Models/CheckchildRes.dart';
import 'package:playgroup/Models/CommonReq.dart';
import 'package:playgroup/Models/EditChildReq.dart';
import 'package:playgroup/Models/GetChildRes.dart';
import 'package:playgroup/Models/Get_CityRes.dart';
import 'package:playgroup/Models/LoginReq.dart';
import 'package:playgroup/Models/LoginRes.dart';
import 'package:playgroup/Models/RegisterReq.dart';
import 'package:playgroup/Models/Register_Res.dart';
import 'package:playgroup/Models/SearchResultRes.dart';
import 'package:playgroup/Models/UserDetailsRes.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:playgroup/Models/CommonRes.dart';

import '../Utilities/Strings.dart';
part 'ApiService.g.dart';

// Run this code in termial to generate ApiService.g.dart file
//flutter packages pub run build_runner watch --delete-conflicting-outputs

//@RestApi(baseUrl: 'http://3.109.217.67:80/sss/')
//@RestApi(baseUrl: 'https://demo.emeetify.com:81/sss/')
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

@GET("user/Checkchild/{name}/{user_id}")
  Future<CheckchildRes> Checkchild(@Path("name") String name,@Path("user_id") int id);

  @GET("user/searchchild/{name}")
  Future<SearchresultRes> SearchChild(@Path("name") String name,);

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

  @GET("user/getparent/{ChildID}")
  Future<UserDetailsRes> getParentsDetails(@Path("ChildID") int ChildID);

  @GET("user/getchild/{parent_id}")
  Future<GetChildRes> GetChild(@Path("parent_id") int parentid);

  @PUT("user/editchild")
  Future<CommonRes> EditChild(@Body() EditChildReq body);

//////////////////////////////////////////////////////////////////////////////////////////
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
        print("object" + Strings.authToken);
        options.headers["jwt"] = Strings.authToken;
       // options.headers["jwt"] = "08d41a36b34dadcfd6005452deb92037ad85af33b227827ae2f4e2d34b927fa0ae6a83d43cfdcff9";

        options.followRedirects = false;
        options.validateStatus = (status) {
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
