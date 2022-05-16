class WeatherModel {
  List<WData>? data;
  String? cityName;
  dynamic lon;
  String? timezone;
  dynamic lat;
  String? countryCode;
  String? stateCode;

  WeatherModel({data, cityName, lon, timezone, lat, countryCode, stateCode});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <WData>[];
      json['data'].forEach((v) {
        data!.add(WData.fromJson(v));
      });
    }
    cityName = json['city_name'];
    lon = json['lon'];
    timezone = json['timezone'];
    lat = json['lat'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['city_name'] = cityName;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['lat'] = lat;
    data['country_code'] = countryCode;
    data['state_code'] = stateCode;
    return data;
  }

  Map<String, Object?> toMap() {
    return {
      'data': data,
      'city_name': cityName,
      'lon': lon,
      'timezone': timezone,
      'lat': lat,
      'country_code': countryCode,
      'state_code': stateCode,
    };
  }

  WeatherModel.fromMap(Map<String, dynamic> map) {
    if (map['data'] != null) {
      data = <WData>[];
      map['data'].forEach((v) {
        data!.add(WData.fromMap(v));
      });
    }
    cityName = map['city_name'];
    lon = map['lon'];
    timezone = map['timezone'];
    lat = map['lat'];
    countryCode = map['country_code'];
    stateCode = map['state_code'];
  }
}

class WData {
  int? moonriseTs;
  String? windCdir;
  int? rh;
  dynamic pres;
  dynamic highTemp;
  int? sunsetTs;
  dynamic ozone;
  dynamic moonPhase;
  dynamic windGustSpd;
  int? snowDepth;
  int? clouds;
  int? ts;
  int? sunriseTs;
  dynamic appMinTemp;
  dynamic windSpd;
  int? pop;
  String? windCdirFull;
  dynamic slp;
  dynamic moonPhaseLunation;
  String? validDate;
  dynamic appMaxTemp;
  dynamic vis;
  dynamic dewpt;
  int? snow;
  dynamic uv;
  Weather? weather;
  int? windDir;
  dynamic maxDhi;
  int? cloudsHi;
  dynamic precip;
  dynamic lowTemp;
  dynamic maxTemp;
  int? moonsetTs;
  String? datetime;
  dynamic temp;
  dynamic minTemp;
  int? cloudsMid;
  int? cloudsLow;

  WData(
      {moonriseTs,
      windCdir,
      rh,
      pres,
      highTemp,
      sunsetTs,
      ozone,
      moonPhase,
      windGustSpd,
      snowDepth,
      clouds,
      ts,
      sunriseTs,
      appMinTemp,
      windSpd,
      pop,
      windCdirFull,
      slp,
      moonPhaseLunation,
      validDate,
      appMaxTemp,
      vis,
      dewpt,
      snow,
      uv,
      weather,
      windDir,
      maxDhi,
      cloudsHi,
      precip,
      lowTemp,
      maxTemp,
      moonsetTs,
      datetime,
      temp,
      minTemp,
      cloudsMid,
      cloudsLow});

  WData.fromJson(Map<String, dynamic> json) {
    // print('jsonmoonriseTs: ${json['moonrise_ts']}');
    moonriseTs = json['moonrise_ts'];
    // print('moonriseTs: $moonriseTs');
    windCdir = json['wind_cdir'];
    // print('windCdir: $windCdir');
    rh = json['rh'];
    // print('rh: $rh');
    pres = json['pres'];
    // print('pres: $pres');
    highTemp = json['high_temp'];
    // print('highTemp: $highTemp');
    sunsetTs = json['sunset_ts'];
    // print('sunsetTs: $sunsetTs');
    ozone = json['ozone'];
    // print('ozone: $ozone');
    moonPhase = json['moon_phase'];
    // print('moonPhase: $moonPhase');
    windGustSpd = json['wind_gust_spd'];
    // print('windGustSpd: $windGustSpd');
    snowDepth = json['snow_depth'];
    // print('snowDepth: $snowDepth');
    clouds = json['clouds'];
    // print('clouds: $clouds');
    ts = json['ts'];
    // print('ts: $ts');
    sunriseTs = json['sunrise_ts'];
    // print('sunriseTs: $sunriseTs');
    appMinTemp = json['app_min_temp'];
    // print('appMinTemp: $appMinTemp');
    windSpd = json['wind_spd'];
    // print('windSpd: $windSpd');
    pop = json['pop'];
    // print('pop: $pop');
    windCdirFull = json['wind_cdir_full'];
    // print('windCdirFull: $windCdirFull');
    slp = json['slp'];
    // print('slp: $slp');
    moonPhaseLunation = json['moon_phase_lunation'];
    // print('moonPhaseLunation: $moonPhaseLunation');
    validDate = json['valid_date'];
    // print('validDate: $validDate');
    appMaxTemp = json['app_max_temp'];
    // print('appMaxTemp: $appMaxTemp');
    vis = json['vis'];
    // print('vis: $vis');
    dewpt = json['dewpt'];
    // print('dewpt: $dewpt');
    snow = json['snow'];
    // print('snow: $snow');
    uv = json['uv'];
    // print('uv: $uv');
    weather =
        json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    // print('weather: $weather');
    windDir = json['wind_dir'];
    // print('windDir: $windDir');
    maxDhi = json['max_dhi'];
    // print('maxDhi: $maxDhi');
    cloudsHi = json['clouds_hi'];
    // print('cloudsHi: $cloudsHi');
    precip = json['precip'];
    // print('precip: $precip');
    lowTemp = json['low_temp'];
    // print('lowTemp: $lowTemp');
    maxTemp = json['max_temp'];
    // print('maxTemp: $maxTemp');
    moonsetTs = json['moonset_ts'];
    // print('moonsetTs: $moonsetTs');
    datetime = json['datetime'];
    // print('datetime: $datetime');
    temp = json['temp'];
    // print('temp: $temp');
    minTemp = json['min_temp'];
    // print('minTemp: $minTemp');
    cloudsMid = json['clouds_mid'];
    // print('cloudsMid: $cloudsMid');
    cloudsLow = json['clouds_low'];
    // print('cloudsLow: $cloudsLow');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['moonrise_ts'] = moonriseTs;
    data['wind_cdir'] = windCdir;
    data['rh'] = rh;
    data['pres'] = pres;
    data['high_temp'] = highTemp;
    data['sunset_ts'] = sunsetTs;
    data['ozone'] = ozone;
    data['moon_phase'] = moonPhase;
    data['wind_gust_spd'] = windGustSpd;
    data['snow_depth'] = snowDepth;
    data['clouds'] = clouds;
    data['ts'] = ts;
    data['sunrise_ts'] = sunriseTs;
    data['app_min_temp'] = appMinTemp;
    data['wind_spd'] = windSpd;
    data['pop'] = pop;
    data['wind_cdir_full'] = windCdirFull;
    data['slp'] = slp;
    data['moon_phase_lunation'] = moonPhaseLunation;
    data['valid_date'] = validDate;
    data['app_max_temp'] = appMaxTemp;
    data['vis'] = vis;
    data['dewpt'] = dewpt;
    data['snow'] = snow;
    data['uv'] = uv;
    if (weather != null) {
      data['weather'] = weather!.toJson();
    }
    data['wind_dir'] = windDir;
    data['max_dhi'] = maxDhi;
    data['clouds_hi'] = cloudsHi;
    data['precip'] = precip;
    data['low_temp'] = lowTemp;
    data['max_temp'] = maxTemp;
    data['moonset_ts'] = moonsetTs;
    data['datetime'] = datetime;
    data['temp'] = temp;
    data['min_temp'] = minTemp;
    data['clouds_mid'] = cloudsMid;
    data['clouds_low'] = cloudsLow;
    return data;
  }

  static WData fromMap(v) {
    return WData(
      moonriseTs: v['moonrise_ts'],
      windCdir: v['wind_cdir'],
      rh: v['rh'],
      pres: v['pres'],
      highTemp: v['high_temp'],
      sunsetTs: v['sunset_ts'],
      ozone: v['ozone'],
      moonPhase: v['moon_phase'],
      windGustSpd: v['wind_gust_spd'],
      snowDepth: v['snow_depth'],
      clouds: v['clouds'],
      ts: v['ts'],
      sunriseTs: v['sunrise_ts'],
      appMinTemp: v['app_min_temp'],
      windSpd: v['wind_spd'],
      pop: v['pop'],
      windCdirFull: v['wind_cdir_full'],
      slp: v['slp'],
      moonPhaseLunation: v['moon_phase_lunation'],
      validDate: v['valid_date'],
      appMaxTemp: v['app_max_temp'],
      vis: v['vis'],
      dewpt: v['dewpt'],
      snow: v['snow'],
      uv: v['uv'],
      weather: v['weather'] != null ? Weather.fromMap(v['weather']) : null,
      windDir: v['wind_dir'],
      maxDhi: v['max_dhi'],
      cloudsHi: v['clouds_hi'],
      precip: v['precip'],
      lowTemp: v['low_temp'],
      maxTemp: v['max_temp'],
      moonsetTs: v['moonset_ts'],
      datetime: v['datetime'],
      temp: v['temp'],
      minTemp: v['min_temp'],
      cloudsMid: v['clouds_mid'],
      cloudsLow: v['clouds_low'],
    );
  }
}

class Weather {
  String? icon;
  int? code;
  String? description;

  Weather({icon, code, description});

  Weather.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['code'] = code;
    data['description'] = description;
    return data;
  }

  static fromMap(v) {}
}
