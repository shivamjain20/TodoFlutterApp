
class Task{
  String? id;
  String? todoText;
  late bool isDone;

  Task({
    required this.id, required this.todoText, this.isDone=false
});

  Task.withId({
    required this.id, required this.todoText, this.isDone=false
  });

  // String? get _id => id;
  // String? get _todoText => todoText;
  // bool get _isDone => isDone;
  //
  // set _todoText(String? newtodoText){
  //   if(newtodoText!.length<=255){
  //     this.todoText = newtodoText;
  //   }
  // }
  //
  // set _id(String? newid){
  //   if(newid!.length<=255){
  //     this.id = newid;
  //   }
  // }

  /// convert a task object into map object
  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['columnId']=id;
    map['columnTodoList']=todoText;
    map['columnIsDone']=isDone ? 1 : 0;
    return map;
  }

  /// Extract a map object into task object
  Task.fromMapObject(Map<String, dynamic> map){
    this.id=map['columnId'];
    this.todoText=map['columnTodoList'];
    this.isDone=map['columnIsDone'] ==1 ? true : false;
  }
}