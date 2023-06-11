import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'GOOGLE_MAP_API')
  static const String googleApiKey = _Env.googleApiKey;
  @EnviedField(varName: 'FULLSCREEN_ADMOB_SDK_ID')
  static const String fullScreenAdMobSdkId = _Env.fullScreenAdMobSdkId;
  @EnviedField(varName: 'FULLSCREEN_ADMOB_ID')
  static const String fullScreenAdMobId = _Env.fullScreenAdMobId;
  @EnviedField(varName: 'MAIN_BANNER_ADMOB_SDK_ID')
  // ignore: constant_identifier_names
  static const String main_banner_admob_sdk_id = _Env.main_banner_admob_sdk_id;
  @EnviedField(varName: 'MAIN_BANNER_ADMOB_UNIT_ID')
  // ignore: constant_identifier_names
  static const String main_banner_admob_unit_id =
      _Env.main_banner_admob_unit_id;
}
