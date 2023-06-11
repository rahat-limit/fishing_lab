// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_provider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LogProvider on _LogProviderBase, Store {
  Computed<List<LogModel>>? _$getLogsComputed;

  @override
  List<LogModel> get getLogs =>
      (_$getLogsComputed ??= Computed<List<LogModel>>(() => super.getLogs,
              name: '_LogProviderBase.getLogs'))
          .value;

  late final _$logsAtom = Atom(name: '_LogProviderBase.logs', context: context);

  @override
  ObservableList<LogModel> get logs {
    _$logsAtom.reportRead();
    return super.logs;
  }

  @override
  set logs(ObservableList<LogModel> value) {
    _$logsAtom.reportWrite(value, super.logs, () {
      super.logs = value;
    });
  }

  late final _$addToLogsAsyncAction =
      AsyncAction('_LogProviderBase.addToLogs', context: context);

  @override
  Future addToLogs(
      {required String title,
      required String description,
      String fishName = '',
      double fishLong = 0,
      double fishWeight = 0,
      File? image}) {
    return _$addToLogsAsyncAction.run(() => super.addToLogs(
        title: title,
        description: description,
        fishName: fishName,
        fishLong: fishLong,
        fishWeight: fishWeight,
        image: image));
  }

  late final _$getDataFromLocalDBAsyncAction =
      AsyncAction('_LogProviderBase.getDataFromLocalDB', context: context);

  @override
  Future getDataFromLocalDB() {
    return _$getDataFromLocalDBAsyncAction
        .run(() => super.getDataFromLocalDB());
  }

  late final _$removeFromLogsAsyncAction =
      AsyncAction('_LogProviderBase.removeFromLogs', context: context);

  @override
  Future removeFromLogs({required String id}) {
    return _$removeFromLogsAsyncAction.run(() => super.removeFromLogs(id: id));
  }

  @override
  String toString() {
    return '''
logs: ${logs},
getLogs: ${getLogs}
    ''';
  }
}
