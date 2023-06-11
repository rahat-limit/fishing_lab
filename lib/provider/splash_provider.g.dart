// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_provider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SplashProvider on _SplashProviderBase, Store {
  late final _$checkedAtom =
      Atom(name: '_SplashProviderBase.checked', context: context);

  @override
  int get checked {
    _$checkedAtom.reportRead();
    return super.checked;
  }

  @override
  set checked(int value) {
    _$checkedAtom.reportWrite(value, super.checked, () {
      super.checked = value;
    });
  }

  late final _$defineCheckedAsyncAction =
      AsyncAction('_SplashProviderBase.defineChecked', context: context);

  @override
  Future defineChecked() {
    return _$defineCheckedAsyncAction.run(() => super.defineChecked());
  }

  @override
  String toString() {
    return '''
checked: ${checked}
    ''';
  }
}
