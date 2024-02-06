import 'package:firebase_auth/firebase_auth.dart';

class ListData{
  late int userId;
  late int id;
  late String title;
  late String completed;

  ListData(this.userId, this.id, this.title, this.completed ) ;
}