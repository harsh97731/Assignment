class ModelCustomer {
  int? createdAt;
  int? updatedAt;
  String? id;
  String? name;
  String? displayName;
  String? email;
  String? phone;
  String? loginWith;
  String? token;
  String? photoUrl;
  String? dob;
  int? age;
  String? gender;
  String? socialMediaID;
  String? isNameForPulic;
  String? password;
  bool? isActive;
  bool? isVerified;
  bool? isDeleted;
  bool? isSignUpComplete;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  int? deletedAt;
  String? shoppingFor;
  String? loginLinkToken;

  //int? loginLinkTime;
  String? verificationLinkToken;

  //int? verificationLinkTime;
  String? resetPassLinkToken;
  int? resetPassLinkTime;
  String? address;
  String? postcode;
  String? lat;
  String? long;
  String? stripeCustomerId;

  ModelCustomer(
      {this.createdAt,
      this.updatedAt,
      this.id,
      this.name,
      this.displayName,
      this.email,
      this.phone,
      this.loginWith,
      this.token,
      this.photoUrl,
      this.dob,
      this.age,
      this.gender,
      this.socialMediaID,
      this.isNameForPulic,
      this.password,
      this.isActive,
      this.isVerified,
      this.isDeleted,
      this.isSignUpComplete,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.deletedAt,
      this.shoppingFor,
      this.loginLinkToken,
      //this.loginLinkTime,
      this.verificationLinkToken,
      //  this.verificationLinkTime,
      this.resetPassLinkToken,
      //this.resetPassLinkTime,
      this.address,
      this.postcode,
      this.lat,
      this.long,
      this.stripeCustomerId});

  ModelCustomer.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    email = json['email'];
    phone = json['phone'];
    loginWith = json['loginWith'];
    token = json['token'];
    photoUrl = json['photoUrl'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    socialMediaID = json['socialMediaID'];
    isNameForPulic = json['isNameForPulic'];
    password = json['password'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    isSignUpComplete = json['isSignUpComplete'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    deletedAt = json['deletedAt'];
    shoppingFor = json['shoppingFor'];
    loginLinkToken = json['loginLinkToken'];
    //loginLinkTime = json['loginLinkTime'];
    verificationLinkToken = json['verificationLinkToken'];
    // verificationLinkTime = json['verificationLinkTime'];
    resetPassLinkToken = json['resetPassLinkToken'];
    //resetPassLinkTime = json['resetPassLinkTime'];
    address = json['address'];
    postcode = json['postcode'];
    lat = json['lat'];
    long = json['long'];
    stripeCustomerId = json['stripeCustomerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['email'] = email;
    data['phone'] = phone;
    data['loginWith'] = loginWith;
    data['token'] = token;
    data['photoUrl'] = photoUrl;
    data['dob'] = dob;
    data['age'] = age;
    data['gender'] = gender;
    data['socialMediaID'] = socialMediaID;
    data['isNameForPulic'] = isNameForPulic;
    data['password'] = password;
    data['isActive'] = isActive;
    data['isVerified'] = isVerified;
    data['isDeleted'] = isDeleted;
    data['isSignUpComplete'] = isSignUpComplete;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['deletedBy'] = deletedBy;
    data['deletedAt'] = deletedAt;
    data['shoppingFor'] = shoppingFor;
    data['loginLinkToken'] = loginLinkToken;
    data['verificationLinkToken'] = verificationLinkToken;
    data['resetPassLinkToken'] = resetPassLinkToken;
    data['address'] = address;
    data['postcode'] = postcode;
    data['lat'] = lat;
    data['long'] = long;
    data['stripeCustomerId'] = stripeCustomerId;
    return data;
  }
}
