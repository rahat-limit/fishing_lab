// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_provider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TipProvider on _TipProviderBase, Store {
  Computed<List<TipModel>>? _$getTipsComputed;

  @override
  List<TipModel> get getTips =>
      (_$getTipsComputed ??= Computed<List<TipModel>>(() => super.getTips,
              name: '_TipProviderBase.getTips'))
          .value;

  late final _$tipsAtom = Atom(name: '_TipProviderBase.tips', context: context);

  @override
  ObservableList<TipModel> get tips {
    _$tipsAtom.reportRead();
    return super.tips;
  }

  @override
  set tips(ObservableList<TipModel> value) {
    _$tipsAtom.reportWrite(value, super.tips, () {
      super.tips = value;
    });
  }

  @override
  String toString() {
    return '''
tips: ${tips},
getTips: ${getTips}
    ''';
  }
}
