import 'package:fishing_lab/models/tip_model.dart';
import 'package:mobx/mobx.dart';
part 'tip_provider.g.dart';

// ignore: library_private_types_in_public_api
class TipProvider = _TipProviderBase with _$TipProvider;

abstract class _TipProviderBase with Store {
  @observable
  ObservableList<TipModel> tips = ObservableList.of([
    TipModel(
        shortText: 'Use the right bait',
        fullText:
            'Different fish species are attracted to specific types of bait. Research or consult local anglers to determine the best bait options for your target fish.',
        path: 'assets/images/fishing-baits.png'),
    TipModel(
        shortText: 'Pay attention to the weather',
        fullText:
            'Weather conditions can significantly affect fish behavior. Keep an eye on temperature, wind direction, and barometric pressure. Fish are more likely to be active during favorable weather patterns.',
        path: 'assets/images/weather.png'),
    TipModel(
        shortText: 'Learn to read the water',
        fullText:
            "Understand the structure of the water body you're fishing in, such as rocks, submerged vegetation, or drop-offs. These features attract fish as they provide shelter and food sources.",
        path: 'assets/images/sea-life.png'),
    TipModel(
        shortText: 'Practice catch and release',
        fullText:
            " If you're not planning to keep the fish, handle them carefully and release them back into the water quickly. This helps preserve fish populations and ensures the sustainability of the ecosystem.",
        path: 'assets/images/fishing-net.png'),
  ]);
  @computed
  List<TipModel> get getTips => tips;
}
