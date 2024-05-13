class IosDevice {
  const IosDevice({
    required this.device,
    required this.logicalWidth,
    required this.logicalHeight,
    required this.width,
    required this.height,
    required this.ppi,
    required this.scaleFactor,
    required this.screenDiagonal,
    required this.releaseDate,
    required this.hardwareNames,
  });

  factory IosDevice.fromJson(Map<String, dynamic> json) {
    return IosDevice(
      device: json['device'],
      logicalWidth: json['logicalWidth'],
      logicalHeight: json['logicalHeight'],
      width: json['width'],
      height: json['height'],
      ppi: json['ppi'],
      scaleFactor: json['scaleFactor'],
      screenDiagonal: json['screenDiagonal'],
      releaseDate: DateTime.parse(json['releaseDate']),
      hardwareNames: (json['hardware_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  final String device;

  final double logicalWidth;

  final double logicalHeight;

  final double width;

  final double height;

  final double ppi;

  final double scaleFactor;

  final double screenDiagonal;

  final DateTime releaseDate;

  final List<String> hardwareNames;
}
