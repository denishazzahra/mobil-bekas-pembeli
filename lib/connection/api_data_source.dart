import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  static Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    return BaseNetwork.post("user/login", body);
  }

  static Future<Map<String, dynamic>> signup(Map<String, dynamic> body) async {
    return BaseNetwork.post("user/signup", body);
  }

  static Future<Map<String, dynamic>> getProducts() async {
    return BaseNetwork.get("product");
  }
}
