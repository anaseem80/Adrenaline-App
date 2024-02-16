import 'package:dio/dio.dart';

class DioHelper
{
  static main() async {
    var dio = Dio();
    final response = await dio.get('http://arabmedicne.online/mobileAPI/courses.php');
    print(response.data);
  }
}