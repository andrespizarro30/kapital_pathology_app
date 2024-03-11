import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:kapital_pathology_app/models/UsersModel.dart';

class ServerDataProvider{

  late UsersResponse usersResponse;
  String _url = 'generalwebservicesapi.azurewebsites.net';
  bool _loading = false;

  final usersLoginStreamController = StreamController<UsersResponse>.broadcast();

  void disposeUserLoginStream(){
    usersLoginStreamController.close();
  }

  Function(UsersResponse) get usersLoginSink => usersLoginStreamController.sink.add;

  Stream<UsersResponse> get usersLoginStream => usersLoginStreamController.stream;

  Future<List<UsersResponse>> processUsersLogin(Uri url) async{

    try{
      final response = await http.get(url);

      var resp = response.body;

      //final decodeData = json.decode(response.body);

      final userResponse =(json.decode(response.body) as List).map((i) => UsersResponse.fromJson(i)).toList();

      //final userResponse = UsersResponse.fromJson(decodeData);

      return userResponse;
    }catch(e){
      String a = "";
    }

    return [UsersResponse()];

  }

  final userLoginQueryParameters = <String,dynamic>{
    "param1" : "",
    "param2" : "",
  };

  Future<UsersResponse> usersLogin(String user,String pwd) async{

    if(_loading){
      return UsersResponse();
    }else{
      _loading = true;
    }


    userLoginQueryParameters['param1'] = user;
    userLoginQueryParameters['param2'] = pwd;

    final url = Uri.https(_url,'/api/userLogin',userLoginQueryParameters);

    final response = await processUsersLogin(url);

    if(response.isNotEmpty){
      usersResponse = response[0];
    }else{
      usersResponse = UsersResponse();
    }

    usersLoginSink(usersResponse);

    _loading = false;

    return usersResponse;


  }




}