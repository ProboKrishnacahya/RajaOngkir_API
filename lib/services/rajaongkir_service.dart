part of 'services.dart';

class RajaOngkirService {
  static Future<http.Response> getOngkir() {
    return http.post(
      Uri.https(Const.baseUrl, "/starter/cost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
      body: jsonEncode(
        <String, dynamic>{
          'origin': '501',
          'destination': '114',
          'weight': 2500,
          'courier': 'jne',
        },
      ),
    );
  }

  static Future<List<Costs>> getMyOngkir(
      dynamic origin, dynamic destination, int weight, dynamic courier) async {
    var response = await http.post(
      Uri.https(Const.baseUrl, "/starter/cost"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      },
      body: jsonEncode(
        <String, dynamic>{
          'origin': origin,
          'destination': destination,
          'weight': weight,
          'courier': courier,
        },
      ),
    );

    var job = json.decode(response.body);
    List<Costs> costs = [];

    if (response.statusCode == 200) {
      costs = (job['rajaongkir']['results'][0]['costs'] as List)
          .map((data) => Costs.fromJson(data))
          .toList();
    }

    return costs;
  }
}
