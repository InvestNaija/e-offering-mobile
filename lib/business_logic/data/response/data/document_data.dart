class DocumentData{
  String name;
  String value;

  DocumentData.fromJson(Map<String, dynamic> json){
    name = json['name'];
    value = json['value'];
  }
}