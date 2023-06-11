import 'package:fishing_lab/services/auth_service.dart';
import 'package:mobx/mobx.dart';
part 'auth_provider.g.dart';

// ignore: library_private_types_in_public_api
class AuthProvider = _AuthProviderBase with _$AuthProvider;

abstract class _AuthProviderBase with Store {
  @observable
  int isAuthed = 0;
  @action
  checkIsAuthed() async {
    await AuthService().isAuthed().then((authed) {
      if (!authed) {
        isAuthed = 0;
        return;
      } else {
        isAuthed = 1;
        return;
      }
    });
  }
}
