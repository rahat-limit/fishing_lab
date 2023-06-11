// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationProvider on _LocationProviderBase, Store {
  Computed<List<Place>>? _$searchPlacesComputed;

  @override
  List<Place> get searchPlaces => (_$searchPlacesComputed ??=
          Computed<List<Place>>(() => super.searchPlaces,
              name: '_LocationProviderBase.searchPlaces'))
      .value;
  Computed<List<Place>>? _$getPlacesComputed;

  @override
  List<Place> get getPlaces =>
      (_$getPlacesComputed ??= Computed<List<Place>>(() => super.getPlaces,
              name: '_LocationProviderBase.getPlaces'))
          .value;
  Computed<bool>? _$getTipModeComputed;

  @override
  bool get getTipMode =>
      (_$getTipModeComputed ??= Computed<bool>(() => super.getTipMode,
              name: '_LocationProviderBase.getTipMode'))
          .value;

  late final _$initLocationAtom =
      Atom(name: '_LocationProviderBase.initLocation', context: context);

  @override
  LocationModel? get initLocation {
    _$initLocationAtom.reportRead();
    return super.initLocation;
  }

  @override
  set initLocation(LocationModel? value) {
    _$initLocationAtom.reportWrite(value, super.initLocation, () {
      super.initLocation = value;
    });
  }

  late final _$placesAtom =
      Atom(name: '_LocationProviderBase.places', context: context);

  @override
  ObservableList<Place> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableList<Place> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  late final _$tipsModeAtom =
      Atom(name: '_LocationProviderBase.tipsMode', context: context);

  @override
  bool get tipsMode {
    _$tipsModeAtom.reportRead();
    return super.tipsMode;
  }

  @override
  set tipsMode(bool value) {
    _$tipsModeAtom.reportWrite(value, super.tipsMode, () {
      super.tipsMode = value;
    });
  }

  late final _$getLocationModelAsyncAction =
      AsyncAction('_LocationProviderBase.getLocationModel', context: context);

  @override
  Future getLocationModel({bool init = false}) {
    return _$getLocationModelAsyncAction
        .run(() => super.getLocationModel(init: init));
  }

  late final _$addToPlacesAsyncAction =
      AsyncAction('_LocationProviderBase.addToPlaces', context: context);

  @override
  Future addToPlaces(
      {required String title, required double lat, required double lng}) {
    return _$addToPlacesAsyncAction
        .run(() => super.addToPlaces(title: title, lat: lat, lng: lng));
  }

  late final _$getFromLocalDBAsyncAction =
      AsyncAction('_LocationProviderBase.getFromLocalDB', context: context);

  @override
  Future getFromLocalDB() {
    return _$getFromLocalDBAsyncAction.run(() => super.getFromLocalDB());
  }

  late final _$addToLocalDbAsyncAction =
      AsyncAction('_LocationProviderBase.addToLocalDb', context: context);

  @override
  Future addToLocalDb(Place place) {
    return _$addToLocalDbAsyncAction.run(() => super.addToLocalDb(place));
  }

  late final _$removeFromLocalDBAsyncAction =
      AsyncAction('_LocationProviderBase.removeFromLocalDB', context: context);

  @override
  Future removeFromLocalDB(String id) {
    return _$removeFromLocalDBAsyncAction
        .run(() => super.removeFromLocalDB(id));
  }

  late final _$removePointAsyncAction =
      AsyncAction('_LocationProviderBase.removePoint', context: context);

  @override
  Future removePoint(String id) {
    return _$removePointAsyncAction.run(() => super.removePoint(id));
  }

  late final _$_LocationProviderBaseActionController =
      ActionController(name: '_LocationProviderBase', context: context);

  @override
  dynamic changeTipsMode() {
    final _$actionInfo = _$_LocationProviderBaseActionController.startAction(
        name: '_LocationProviderBase.changeTipsMode');
    try {
      return super.changeTipsMode();
    } finally {
      _$_LocationProviderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeTargetLocation(LocationModel location) {
    final _$actionInfo = _$_LocationProviderBaseActionController.startAction(
        name: '_LocationProviderBase.changeTargetLocation');
    try {
      return super.changeTargetLocation(location);
    } finally {
      _$_LocationProviderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic search(String key) {
    final _$actionInfo = _$_LocationProviderBaseActionController.startAction(
        name: '_LocationProviderBase.search');
    try {
      return super.search(key);
    } finally {
      _$_LocationProviderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSearchHistory() {
    final _$actionInfo = _$_LocationProviderBaseActionController.startAction(
        name: '_LocationProviderBase.clearSearchHistory');
    try {
      return super.clearSearchHistory();
    } finally {
      _$_LocationProviderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initLocation: ${initLocation},
places: ${places},
tipsMode: ${tipsMode},
searchPlaces: ${searchPlaces},
getPlaces: ${getPlaces},
getTipMode: ${getTipMode}
    ''';
  }
}
