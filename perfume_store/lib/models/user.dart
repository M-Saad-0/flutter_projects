class MyUser{
  final String name;
  final String address;
  final String email;

  const MyUser({required this.name, required this.address, required this.email});

  factory MyUser.fromJson(Map<String, dynamic> user){
    return MyUser(name: user['name'], address: user['address'], email: user['email']);
  }

  static Map<String, dynamic> toJson(MyUser user){
    return {
      'name': user.name,
      'address': user.address,
      'email': user.email
    };
  }
}