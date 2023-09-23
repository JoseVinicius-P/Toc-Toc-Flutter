import 'package:flutter_test/flutter_test.dart';
import 'package:toctoc/app/modules/perfil/user_model.dart';

void main(){
  test('Caso o nome estja vazio deve lançar uma exeção', (){
    UserModel user;
    user = UserModel.empty();
    expect(() => user.toFirestore(), throwsA(isA<Exception>()));
    user = UserModel.onlyName(name: "   ");
    expect(() => user.toFirestore(), throwsA(isA<Exception>()));
  });
}