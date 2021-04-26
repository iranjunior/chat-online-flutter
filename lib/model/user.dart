import 'package:firebase_auth/firebase_auth.dart';

class UserApp {
  String name;
  String email;
  String uid;
  String photo;

  UserApp.fromUserFirebase(User user) {
    this.name = user.displayName;
    this.email = user.email;
    this.uid = user.uid;
    this.photo = user.photoURL;
  }
  @override
  String toString() {
    return 'name: $name, email: $email, id: $uid, photo: $photo';
  }
}
