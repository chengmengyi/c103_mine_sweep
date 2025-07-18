import 'package:c103_mine_sweep/mine_sweep_utils/http/ms_http_result.dart';
import 'package:dio/dio.dart';

class MsHttpUtils {
  static final MsHttpUtils _baseDio=MsHttpUtils();
  static MsHttpUtils get instance=>_baseDio;

  Dio? _dio;
  MsHttpUtils(){
    _dio??=Dio(BaseOptions(
      responseType: ResponseType.json,
      receiveDataWhenStatusError: false,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  Future<MsHttpResult> requestPost({
    required String path,
    required dynamic data,
    Map<String,dynamic>? header,
    String? contentType,
  })async{
    if(null!=header){
      _dio?.options.headers=header;
    }
    if(null!=contentType){
      _dio?.options.contentType=contentType;
    }
    try{
      var response = await _dio?.request<String>(
          path,
          data: data,
          options: Options(method: "post")
      );
      return MsHttpResult(success: response?.statusCode==200, msg: response?.data??"");
    }catch(e){
      return MsHttpResult(success: false, msg: "");
    }
  }
}