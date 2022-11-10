class PostCode {
  PostCode({
    required this.postCode,
    required this.country,
    required this.countryAbbreviation,
    required this.places,
  });

  late final String? postCode;
  late final String country;
  late final String countryAbbreviation;
  late final List<Places> places;

  PostCode.fromJson(Map<String, dynamic> json) {
    postCode = json['post code'];
    country = json['country'];
    countryAbbreviation = json['country abbreviation'];
    places = List.from(json['places']).map((e) => Places.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['post code'] = postCode;
    data['country'] = country;
    data['country abbreviation'] = countryAbbreviation;
    data['places'] = places.map((e) => e.toJson()).toList();
    return data;
  }
}

class Places {
  Places({
    required this.placeName,
    required this.longitude,
    required this.state,
    required this.postCode,
    required this.stateAbbreviation,
    required this.latitude,
  });

  late final String placeName;
  late final String? state;
  late final String? postCode;
  late final String? stateAbbreviation;
  late final double longitude;
  late final double latitude;

  Places.fromJson(Map<String, dynamic> json) {
    placeName = json['place name'];
    postCode = json['post code'];
    state = json['state'];
    stateAbbreviation = json['state abbreviation'];
    longitude = double.tryParse(json['longitude']) ?? 0;
    latitude = double.tryParse(json['latitude']) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['place name'] = placeName;
    data['state'] = state;
    data['state abbreviation'] = stateAbbreviation;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
