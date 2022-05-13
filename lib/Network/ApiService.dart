import 'package:dio/dio.dart';
import 'package:playgroup/Models/CommonReq.dart';
import 'package:playgroup/Models/Get_CityRes.dart';
import 'package:playgroup/Models/LoginReq.dart';
import 'package:playgroup/Models/RegisterReq.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:playgroup/Models/CommonRes.dart';
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
  Future<CommonRes> login(@Body() LoginReq body);

  @POST("user/register")
  Future<CommonRes> Register(@Body() UserRegisterReq body);

  @GET("user/get_City/IN/TN")
  Future<GetCity> Get_City();

  @GET("user/check/{EmailOrPhone_No}/null")
  Future<CommonRes> CheckUser(@Path("EmailOrPhone_No") String EmailOrPhone_No);

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

        //  options.headers["jwt"] = Strings.authToken;

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
