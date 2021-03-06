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
  Future<CommonRes> EditAvailability(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/updatemark',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> updateFCM(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/updatefcm',
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
  Future<CommonRes> unLike(ChildID, markavailId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(Options(
                method: 'DELETE', headers: _headers, extra: _extra)
            .compose(
                _dio.options, 'comment/deletelike/${ChildID}/${markavailId}',
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
  Future<GetChildProfileRes> getchildProfile(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetChildProfileRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/getchildid/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetChildProfileRes.fromJson(_result.data!);
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
                .compose(_dio.options,
                    'user/checkfriendsbyid/${ChildID}/${otherChild_id}',
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
  Future<CommonRes> updateAccess(access) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/changeAccess/${access}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
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
  Future<CommonRes> deleteCoParent() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/coparent',
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
  Future<CommonRes> editChildLanguages(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/editlanguage',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> EditChildInterest(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/editinterest',
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
  Future<GetAllActivities> GetAllActivity(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllActivities>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/get_all_activites/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllActivities.fromJson(_result.data!);
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
  Future<GetInterestsRes> GetInterests(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetInterestsRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/getinterest/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetInterestsRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OwnAvailabilityDetailsRes> getAvailabilityDetails(
      availability_id, ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OwnAvailabilityDetailsRes>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/mark/getmarkbyid/${availability_id}/${ChildID}',
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
  Future<CommonRes> BlockFriends(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/blockmails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> ReportUser(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/report',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
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

  @override
  Future<GetAllActivities> GetMarkAvailability(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllActivities>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/getmark/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllActivities.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OtherMarkAvailabilityRes> GetOtherMarkAvailability(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OtherMarkAvailabilityRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/join_markavail_list/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OtherMarkAvailabilityRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> JoinFriendsMarkAvailability(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/joinfriends',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> suggestTime(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/suggesttime',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> updateCoParent(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user/updateCoParent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetNotificationListRes> GetNotificationList(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetNotificationListRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/notification_list/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetNotificationListRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> updateNotificationstatus(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/update_notification_status',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateGroupRes> CreateGroup(body, ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateGroupRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/create/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateGroupRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> updateGroup(body, groupId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/update/${groupId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetGroupDetailsByIdRes> GetGroupDetailsbyId(groupId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetGroupDetailsByIdRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/getDetails/${groupId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetGroupDetailsByIdRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllGroupDetailsRes> GetAllGroupDetails(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllGroupDetailsRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/getAll/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllGroupDetailsRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GroupsAndFriends> GetGroupFriends(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GroupsAndFriends>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/all/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GroupsAndFriends.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> addParticipantsGroup(body, groupId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/add_participants/${groupId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> exitGroup(groupId, ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/exitGroup/${groupId}/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> removeParticipantsGroup(body, ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'groups/remove_participants/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PastActivitiesRes> PastActivities(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PastActivitiesRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/get_past_mark/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PastActivitiesRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PastActivityByIdRes> PastActivityById(markavailId, ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PastActivityByIdRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'mark/get_past_markbyid/${markavailId}/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PastActivityByIdRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<getPastActPhotos> getPastActPhoto(markavailId, ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<getPastActPhotos>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, 'mark/get_past_images/${markavailId}/${ChildID}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getPastActPhotos.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> uploadPastActPhoto(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'mark/add_past_photos',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> addLike(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'comment/addlike',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> DeletePastImgs(pastActivitiesImagesId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'mark/delete_past_images/${pastActivitiesImagesId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetChatsList> GetChatList(ChildID) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetChatsList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'chat/getchat_list/${ChildID}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetChatsList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> uploadIndChatVoice(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'chat/upload_chat_audio',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> uploadGroupChatVoice(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'chat/upload_chat_audio',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommonRes> uploadAvailChatVoice(body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommonRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'chat/upload_chat_audio',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommonRes.fromJson(_result.data!);
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
