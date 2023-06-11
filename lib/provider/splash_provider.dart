import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_provider.g.dart';

// ignore: library_private_types_in_public_api
class SplashProvider = _SplashProviderBase with _$SplashProvider;

abstract class _SplashProviderBase with Store {
  @observable
  int checked = 0;

  @action
  defineChecked() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    // - to see intro screen
    bool check = pref.getBool('seen') ?? false;
    if (!check) {
      await pref.setBool('seen', true);
      checked = 1;

      return 1; //home
    }
    checked = 0;

    return 0; //splash
  }
}
