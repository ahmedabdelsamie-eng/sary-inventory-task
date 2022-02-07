class AppServices {
//   static Future<LoginModel> userLogin(
//       {String userEmail, String password}) async {
//     LoginModel loginModel;
//     print('error from services');
//     try {
//       final response = await DioHelper.postData(
//           url: Login,
//           data: {'email': userEmail, 'password': password},
//           lang: 'en');
// //المفروض نفك هنا التشفير بتاع الجسون
// //في الطبيعي المفروض تعمل تحقق هنا علي الريسبونص ستاتس كود 200
// //التشفير ممكن يحصل في الهيلبر مش لازم هنا فالسيرفيس
//       loginModel = LoginModel.fromJson(response.data);
//       print(response.statusCode);
//       return loginModel;
//     } catch (error) {
//       throw HttpException(message: error.toString());
//     }
//   }
}
