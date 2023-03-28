import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/parser.dart';
import 'package:lw_seller/account_manager/factory.dart';

class Network {
  static Dio dio = Dio();

  Network._();

  static final Network _instance = Network._();

  static Network get instance => _instance;

  void create() async {
    var dio = Dio(BaseOptions(
        connectTimeout: 1000,
        receiveTimeout: 1000,
        sendTimeout: 1000,
        responseType: ResponseType.json,
        followRedirects: false,
        validateStatus: (status) {
          return true;
        }
    ));
  }

  //TODO: refactor cringe code

  String c(response) {
    RegExp exp = RegExp("id=\"authentification(.{5})\" type");
    RegExpMatch? match = exp.firstMatch(response.data);
    const start = 'authentification';
    const end = '"';
    final startIndex = match![0]!.indexOf(start);
    final endIndex = match![0]!.indexOf(end, startIndex + start.length);
    final code = match![0]!.substring(startIndex + start.length, endIndex);
    RegExp exp2 = RegExp("value=\"(.{32})\" name=");
    RegExpMatch? match2 = exp2.firstMatch(response.data);
    const start2 = 'value="';
    const end2 = '"';
    final startIndex2 = match2![0]!.indexOf(start2);
    final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
    final code2 = match2![0]!
        .substring(startIndex2 + start2.length, endIndex2)
        .toLowerCase();

    return code;
  }
  String c2(response) {
    RegExp exp = RegExp("id=\"authentification(.{5})\" type");
    RegExpMatch? match = exp.firstMatch(response.data);
    const start = 'authentification';
    const end = '"';
    final startIndex = match![0]!.indexOf(start);
    final endIndex = match![0]!.indexOf(end, startIndex + start.length);
    final code = match![0]!.substring(startIndex + start.length, endIndex);
    RegExp exp2 = RegExp("value=\"(.{32})\" name=");
    RegExpMatch? match2 = exp2.firstMatch(response.data);
    const start2 = 'value="';
    const end2 = '"';
    final startIndex2 = match2![0]!.indexOf(start2);
    final endIndex2 = match2![0]!.indexOf(end2, startIndex2 + start2.length);
    final code2 = match2![0]!
        .substring(startIndex2 + start2.length, endIndex2)
        .toLowerCase();

    return code2;
  }

  Future<bool> login(login, password) async {
    create();
    var ex = false;

    dio.interceptors.add(CookieManager(CookieJar()));

    var firstResponse = await dio.get(
        "https://www.lowadi.com");
    final data = firstResponse;

    await Future.delayed(const Duration(seconds: 1), () async {
      var loginResponse = await dio.post(
          "https://www.lowadi.com/site/doLogIn",
          data: FormData.fromMap(
              {
                c(data): c2(data),
                'login': login,
                'password': password,
                'redirection': '',
                'isBoxStyle': ''
              }
          ));
      ex = loginResponse.headers.toString().contains('hasLoggedIn');

    });

    return ex ? false : true;
  }

  Future<List<Factory>> getFactory() async {
    var response = await dio.get('https://www.lowadi.com/elevage/chevaux/?elevage=all-horses');
    final document = parse(response.data);
    final factories = document.querySelector("#tab-all-breeding")!.children;
    factories.removeLast();
    final List<Factory> list = [];

    for(var i = 0; i < factories.length; i++) {
      final factory = factories[i];
      final name = factory.text.trim();
      final id = factory.id.trim().replaceAll('tab-select-', '');
      list.add(Factory(name: name, id: id));
    }

    return list;
  }

}