class CustomerResponseModel{
  String accountType;
  String id;
  String description;
  String firstName;
  String lastName;
  String middleName;
  String bvn;
  String nin;
  String address;
  String email;
  String gender;
  String dob;
  String phone;
  String cscs;
  String chn;
  String cscsRef;
  bool cscsVerified;
  String cscsRequestStatus;
  String cscsRequestFailureReason;
  String role;
  bool verified;
  String status;
  String bankAccountName;
  String bankName;
  String bankCode;
  String nuban;
  String zanibalId;
  String image;
  String driverLicense = '';
  String driverLicenseNo;
  String passport = '';
  String passportNo;
  String nationalId = '';
  String nationalIdNo;
  String utility = '';
  String utilityNo;
  String website;
  String twitter;
  String facebook;
  String linkedIn;
  String youtube;
  String createdAt;
  String updatedAt;
  String brokerId;
  String mothersMaidenName;

  CustomerResponseModel();

  CustomerResponseModel.fromJson(Map<String, dynamic> json) :
   accountType = json["accountType"],
   id = json["id"],
   mothersMaidenName = json['mothersMaidenName'],
   description = json["description"],
   firstName = json["firstName"],
   lastName = json["lastName"],
   middleName = json["middleName"],
   bvn = json["bvn"],
   nin = json["nin"],
   address = json["address"],
   email = json["email"],
   gender = json["gender"],
   dob = json["dob"],
   phone = json["phone"],
   cscs = json["cscs"],
   chn = json["chn"],
   cscsRef = json["cscsRef"],
   cscsVerified = json["cscsVerified"],
   cscsRequestStatus = json["cscsRequestStatus"],
   cscsRequestFailureReason = json["cscsRequestFailureReason"],
   role = json["role"],
   verified = json["verified"],
   status = json["status"],
   bankAccountName = json["bankAccountName"],
   bankName = json["bankName"],
   bankCode = json["bankCode"],
   nuban = json["nuban"],
   zanibalId = json["zanibalId"],
   image = json["image"],
   driverLicense = json["driverLicense"] ?? '',
   driverLicenseNo = json["driverLicenseNo"],
   passport = json["passport"] ?? '',
   passportNo = json["passportNo"],
   nationalId = json["nationalId"] ?? '',
   nationalIdNo = json["nationalIdNo"],
   utility = json["utility"] ?? '',
   utilityNo = json["utilityNo"],
   website = json["website"],
   twitter = json["twitter"],
   facebook = json["facebook"],
   linkedIn = json["linkedIn"],
   youtube = json["youtube"],
   createdAt = json["createdAt"],
   updatedAt = json["updatedAt"],
   brokerId = json["brokerId"];


  Map<String, dynamic> toJson() => {
        'accountType': accountType,
        'id' : id,
        "description" : description,
        "firstName" : firstName,
        "lastName" : lastName,
        "middleName" : middleName,
        "bvn" : bvn,
        "nin" : nin,
        "mothersMaidenName" : mothersMaidenName,
        "address" : address,
        "email" : email,
        "gender" : gender,
        "dob" : dob,
        "phone" : phone,
        "cscs" : cscs,
        "chn" : chn,
        "cscsRef" : cscsRef,
        "cscsVerified" : cscsVerified,
        "cscsRequestStatus" : cscsRequestStatus,
        "cscsRequestFailureReason" : cscsRequestFailureReason,
        "role" : role,
        "verified" : verified,
        "status" : status,
        "bankAccountName" : bankAccountName,
        "bankName" : bankName,
        "bankCode" : bankCode,
        "nuban" : nuban,
        "zanibalId" : zanibalId,
        "image" : image,
        "driverLicense" : driverLicense,
        "driverLicenseNo" : driverLicenseNo,
        "passport" : passport,
        "passportNo" : passportNo,
        "nationalId" : nationalId,
        "nationalIdNo" : nationalIdNo,
        "utility" : utility,
        "utilityNo" : utilityNo,
        "website" : website,
        "twitter" : twitter,
        "facebook" : facebook,
        "linkedIn" : linkedIn,
        "youtube" : youtube,
        "createdAt" : createdAt,
        "updatedAt" : updatedAt,
        "brokerId" : brokerId
  };
}