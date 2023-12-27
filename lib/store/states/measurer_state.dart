class MeasurerState {
  final double lowerLimit, upperLimit, value;

  const MeasurerState({
    required this.lowerLimit,
    required this.upperLimit,
    required this.value,
  });

  static MeasurerState initialState([
    double lowerLimit = 0,
    double upperLimit = 1,
  ]) {
    return MeasurerState(
      lowerLimit: lowerLimit,
      upperLimit: upperLimit,
      value: 0,
    );
  }

  MeasurerState copy({double? lowerLimit, double? upperLimit, double? value}) {
    return MeasurerState(
      lowerLimit: lowerLimit ?? this.lowerLimit,
      upperLimit: upperLimit ?? this.upperLimit,
      value: value ?? this.value,
    );
  }
}
