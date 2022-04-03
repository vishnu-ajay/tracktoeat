class MessDetails {
  String nameOfMess,
      messRepName,
      messRepEmail,
      messLocation,
      managerPhoneNo;

  MessDetails(
      {required this.nameOfMess,
      required this.messRepEmail,
      required this.messRepName,
      required this.messLocation,
      required this.managerPhoneNo});

  MessDetails.fromJson(Map<String,dynamic>json)
    :
      nameOfMess = json['nameOfMess'],
      messRepName = json['messRepName'],
      messRepEmail = json['messRepEmail'],
      messLocation = json['messLocation'],
      managerPhoneNo = json['messManagerPhoneNo'];

  Map<String,dynamic> toJson()=>{
    'nameOfMess' : nameOfMess,
    'messRepName': messRepName,
    'messRepEmail': messRepEmail,
    'messLocation': messLocation,
    'messManagerPhoneNo':managerPhoneNo
  };
}
