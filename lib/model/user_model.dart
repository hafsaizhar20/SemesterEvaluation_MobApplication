class UserModel {

  final Map <String,dynamic> map ;
  const UserModel({
    this.map = const {}
  });
  String get name => map['name'] as String;
  String get phone => map['phone'] as String;
  String get email => map['email'] as String;
  String get image => map['photourl'] as String;
}