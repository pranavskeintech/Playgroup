// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://demo.emeetify.com:81/playgroup/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginRes> login(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Register_Res> Register(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Register_Res>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Register_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Register_Res> ForgotPassword(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Register_Res>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/forgot_pswd',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Register_Res.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> createAvailability(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/addmark',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> addCoParent(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/coparent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckchildRes> Checkchild(name, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckchildRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/Checkchild/${name}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckchildRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchresultRes> SearchChild(name, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchresultRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/searchchild/${id}/${name}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchresultRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCity> Get_City() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCity>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/get_City/IN/TN',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCity.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> CheckUser(EmailOrPhoneNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/check/${EmailOrPhoneNo}/null',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginRes> GoogleLogin(EmailOrPhoneNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/check/${EmailOrPhoneNo}/Google',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginRes> FBLogin(EmailOrPhoneNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/check/${EmailOrPhoneNo}/Facebook',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> AddChild(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/addchild',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> sendFriendRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> deleteFriendRequest(ChildID, otherChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends/${ChildID}/${otherChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> AddChild2(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/addchild',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserDetailsRes> getParentsDetails(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserDetailsRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/getparent/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserDetailsRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OtherChildRes> getOtherchildDetails(ChildID, otherChild_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OtherChildRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'user/getchildid/${ChildID}/${otherChild_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OtherChildRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetChildRes> GetChild() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetChildRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/getchild',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetChildRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetChildRes> DeleteChild(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetChildRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/child/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetChildRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> deleteAvailability(availID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/deletemark/${availID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> pauseAvailability(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/pausemark',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> EditChild(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/editchild',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> ChooseChild(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/updatechild',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> updateParent(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/updateParent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetProfileRes> GetProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetProfileRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/profile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetProfileRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetActivitiesRes> GetActivities() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetActivitiesRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/getactivities',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetActivitiesRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetSportsRes> GetSports(sprotID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetSportsRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/getsports/${sprotID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetSportsRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OwnAvailabilityDetailsRes> getAvailabilityDetails(
      availability_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OwnAvailabilityDetailsRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/mark/getmarkbyid/${availability_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OwnAvailabilityDetailsRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PendingFriendReqRes> GetPendingFriendReq(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PendingFriendReqRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends/${ChildID}/Pending',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PendingFriendReqRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PendingFriendReqRes> getFriends(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PendingFriendReqRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends/${ChildID}/Accepted',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PendingFriendReqRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> AcceptFriendRequest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> CancelFriendReq(ChildID, child_friend_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends/${ChildID}/${child_friend_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AcceptedFriendsRes> GetAcceptedFriendReq(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AcceptedFriendsRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'friends/${ChildID}/Accepted',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AcceptedFriendsRes.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
