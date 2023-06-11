import 'dart:io';

import 'package:fishing_lab/models/log_model.dart';
import 'package:fishing_lab/services/db/log_db.dart';
import 'package:mobx/mobx.dart';
part 'log_provider.g.dart';

// ignore: library_private_types_in_public_api
class LogProvider = _LogProviderBase with _$LogProvider;

abstract class _LogProviderBase with Store {
  @observable
  ObservableList<LogModel> logs = ObservableList<LogModel>.of([
    LogModel(
        title: 'Any luck finding a good fishing spot?',
        description:
            'Every culture in the world has an abundance of superstitions and traditions that are unique to them. When it comes to luck and tradition, anglers have always been among the most superstitious. There have been rituals for better harvest or favorable weather along with symbols of both good and bad luck since the first person caught a fish.',
        date: DateTime.now(),
        fishName: 'Golden Fish',
        fishLong: 139,
        fishWeight: 5500),
    LogModel(
        title: "The biggest fish you've ever caught",
        description:
            "Drink Whisky After Preparing the GearScottland is well known for producing great whisky known around the world as scotch. Drinking happens fairly often among anglers and it’s no surprise that the old Scottish fishermen had a tradition of drinking whisky for good luck.",
        date: DateTime.now(),
        fishName: 'Bony Fish',
        fishLong: 59,
        fishWeight: 1500),
  ]);

  @computed
  List<LogModel> get getLogs => logs;

  @action
  addToLogs({
    required String title,
    required String description,
    String fishName = '',
    double fishLong = 0,
    double fishWeight = 0,
    File? image,
  }) async {
    final DateTime date = DateTime.now();
    final LogModel log = LogModel(
        title: title,
        description: description,
        date: date,
        fishName: fishName,
        fishLong: fishLong,
        fishWeight: fishWeight,
        image: image);
    await LogsLocalStorage().insert(log: log);
    logs.add(log);
  }

  @action
  getDataFromLocalDB() async {
    List<LogModel> newLogs = await LogsLocalStorage().getData();
    logs.addAll(newLogs);
  }

  @action
  removeFromLogs({required String id}) async {
    await LogsLocalStorage().deleteRow(id);
    logs.removeWhere((element) => element.id == id);
  }
}
