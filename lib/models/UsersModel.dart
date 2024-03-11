class UsersResponse {
  int? iD;
  String? usuarios;
  String? clave;

  UsersResponse({
    this.iD,
    this.usuarios,
    this.clave,
  });

  UsersResponse.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] as int?;
    usuarios = json['Usuarios'] as String?;
    clave = json['Clave'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['ID'] = iD;
    json['Usuarios'] = usuarios;
    json['Clave'] = clave;
    return json;
  }
}