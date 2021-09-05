class RegisterRequestModel{
  bool loading;

  RegisterRequestModel({
      this.loading,
      this.firstName,
      this.lastName,
      this.middleName,
      this.dob,
      this.gender,
      this.phone,
      this.address,
      this.email,
      this.nin,
      this.password,
      this.bvn,
      this.placeOfBirth,
      this.mothersMaidenName,
  });

  String firstName;
  String lastName;
  String middleName;
  String dob;
  String gender;
  String phone;
  String address;
  String email;
  String nin;
  String password;
  String bvn;
  String placeOfBirth;
  String mothersMaidenName;

  Map<String, dynamic> toJson()=>
    {
      'loading': loading,
      'firstName' : firstName,
      "lastName" : lastName,
      "middleName" : middleName,
      "dob" : dob,
      "gender" : gender,
      "phone" : phone,
      "address" : address,
      "email" : email,
      "nin" : nin,
      "bvn" : bvn,
      "password" : password,
      "placeOfBirth" : placeOfBirth,
      "mothersMaidenName" : mothersMaidenName
    };
}

