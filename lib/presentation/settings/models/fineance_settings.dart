class FineanceSettings {
  final bool isBiometricsActive;

  FineanceSettings({required this.isBiometricsActive});

  FineanceSettings copyWith({
    bool? isBiometricsActive,
  }) =>
      FineanceSettings(
        isBiometricsActive: isBiometricsActive ?? this.isBiometricsActive,
      );
}
