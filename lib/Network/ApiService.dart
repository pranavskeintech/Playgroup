import 'package:dio/dio.dart';
import 'package:playgroup/Models/CommonReq.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:playgroup/Models/CommonRes.dart';
part 'ApiService.g.dart';



// Run this code in termial to generate ApiService.g.dart file
//flutter packages pub run build_runner watch --delete-conflicting-outputs

//@RestApi(baseUrl: 'http://3.109.217.67:80/sss/')
 //@RestApi(baseUrl: 'https://demo.emeetify.com:81/sss/')
// @RestApi(baseUrl: 'http://172.16.200.70:3445/sss/')
 @RestApi(baseUrl: 'https://uat.ssscbe.com/sss/')

abstract class ApiService 
{
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("user/login")
  Future<CommonRes> login(@Body() CommonReq body);

  

//////////////////////////////////////////////////////////////////////////////////////////
  /// Request and Response Body
//////////////////////////////////////////////////////////////////////////////////////////

  static ApiService create() 
  {
    final dio = Dio();
    try 
    {
      print("check");
      dio.interceptors.add(PrettyDioLogger());
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options,handler) async {
        options.headers["Content-Type"] = "application/json";

      //  options.headers["jwt"] = Strings.authToken;

        options.followRedirects = false;
        options.validateStatus = (status) 
        {
          return status! < 500;
        };
        return handler.next(options) ;
      }));
     
      return ApiService(dio);
    } on DioError catch (error) 
    {
      print("DioError");
      print(error);
      print(error.error);
      return ApiService(dio);
    }
    
  }
}
