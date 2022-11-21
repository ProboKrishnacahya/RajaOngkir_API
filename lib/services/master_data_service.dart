part of 'services.dart';

class MasterDataService {
  static Future<http.Response> getMahasiswa() async {
    var response = await http.get(
      Uri.http("10.0.2.2:8000", "/mahasiswa"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var job = json.decode(response.body);
    print(job.toString());

    return response;
  }

  static Future<List<Province>> getProvince() async {
    var response = await http.get(
      Uri.https(Const.baseUrl, "/starter/province"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
    );
    var job = json.decode(response.body);
    List<Province> result = [];

    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List)
          .map((e) => Province.fromJson(e))
          .toList();
    }

    return result;
  }

  static Future<List<City>> getCity(var provId) async {
    var response = await http.get(
      Uri.https(Const.baseUrl, "/starter/city"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
    );

    var job = json.decode(response.body);
    List<City> result = [];
    if (response.statusCode == 200) {
      result = (job['rajaongkir']['results'] as List)
          .map((e) => City.fromJson(e))
          .toList();
    }

    List<City> selectedCities = [];
    for (var c in result) {
      if (c.provinceId == provId) {
        selectedCities.add(c);
      }
    }

    return selectedCities;
  }
}
