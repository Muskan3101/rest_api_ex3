class Student{
  var name;
  var id;

  Student({this.name, this.id});
  //factory constructor
  factory Student.fromJson(Map<String, dynamic> map){
    return Student(name:map["name"], id:map["id"]);
  }
}