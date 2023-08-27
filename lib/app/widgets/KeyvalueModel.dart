class KeyvalueModel {
  dynamic? name;
  dynamic? key;
  dynamic optional;
  dynamic genderOptional;
  dynamic itemid;
  dynamic desc;
  dynamic minqty;
  dynamic id;
  dynamic idValue;
  dynamic tax;
  dynamic validity;
  dynamic cgst;
  dynamic sgst;
  dynamic min;
  dynamic max;
  dynamic mainCategoryId;
  List<String> sportedCategoryList = [];


  KeyvalueModel({this.name, this.key, this.optional, this.genderOptional,this.itemid,this.desc,this.minqty,this.id,this.idValue,this.validity,
    this.tax,this.sgst,this.cgst,this.max,this.min,this.mainCategoryId});

  static List<KeyvalueModel> ?fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => KeyvalueModel.fromsJson(item)).toList();
  }

  static List<KeyvalueModel>? fromJsonListData(List list) {
    if (list == null) return null;
    List<KeyvalueModel> myList = [];
    list.forEach((element) {
      myList.add(new KeyvalueModel.fromsJson(element));
    });
    return myList;
  }

  KeyvalueModel.fromsJson(Map<String, dynamic> json) {
    key = json['key']??json['classId'].toString();
    name = json['name']??json['className'];
    optional = json['gender_name'].toString();
    itemid = json['itemId'].toString();
    desc = json['desc'].toString();
    minqty = json['minQty'].toString();
    id = (json['id']??json["code"]).toString();
    idValue = json['idValue'].toString();
    validity = json['validity'].toString();
    tax = json['tax'].toString();
    cgst = json['cgst'].toString();
    sgst = json['sgst'].toString();
    min = json['min'].toString();
    max = json['max'].toString();
    mainCategoryId = json['mainCategoryId'].toString();
    if (json.containsKey("optional")) {
      optional = json['optional'].toString();
    }
    if (json.containsKey("genderOptional")) {
      genderOptional = json['genderOptional'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name ;
    data['key'] = this.key;
    data['gender_name'] = this.optional;
    data['genderOptional'] = this.genderOptional;
    data['itemId'] = this.itemid;
    data['id'] = this.id;
    data['idValue'] = this.idValue;
    data['validity'] = this.validity;
    data['desc'] = this.desc;
    data['minqty'] = this.minqty;
    data['tax'] = this.tax;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['min'] = this.min;
    data['max'] = this.max;
    data['mainCategoryId'] = this.mainCategoryId;
    return data;
  }

  @override
  String toString() => name;
}
