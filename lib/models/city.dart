part of 'models.dart';

class City extends Equatable {
  final String? originCityId;
  final String? destinationCityId;
  final String? provinceId;
  final String? province;
  final String? type;
  final String? cityName;
  final String? postalCode;

  const City({
    this.originCityId,
    this.destinationCityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        originCityId: json['city_id'] as String?,
        destinationCityId: json['city_id'] as String?,
        provinceId: json['province_id'] as String?,
        province: json['province'] as String?,
        type: json['type'] as String?,
        cityName: json['city_name'] as String?,
        postalCode: json['postal_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'origin_city_id': originCityId,
        'destination_city_id': destinationCityId,
        'province_id': provinceId,
        'province': province,
        'type': type,
        'city_name': cityName,
        'postal_code': postalCode,
      };

  City copyWith({
    String? originCityId,
    String? destinationCityId,
    String? provinceId,
    String? province,
    String? type,
    String? cityName,
    String? postalCode,
  }) {
    return City(
      originCityId: originCityId ?? this.originCityId,
      destinationCityId: destinationCityId ?? this.destinationCityId,
      provinceId: provinceId ?? this.provinceId,
      province: province ?? this.province,
      type: type ?? this.type,
      cityName: cityName ?? this.cityName,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      originCityId,
      destinationCityId,
      provinceId,
      province,
      type,
      cityName,
      postalCode,
    ];
  }
}
