class DocumentType {
  int id = 0;
  String key = '';
  String value = '';

  DocumentType({ required this.id, required this.key, required this.value});

  DocumentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}