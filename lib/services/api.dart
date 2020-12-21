import 'package:assoesaip_flutter/models/user.dart';
import 'package:requests/requests.dart';

String url = 'https://asso-esaip.bricechk.fr/api';

Future<User> getUser() async {
  final response = await Requests.get('$url/profile');
  if (response.hasError) {
    return null;
  }
  return userFromJson(response.content());
}