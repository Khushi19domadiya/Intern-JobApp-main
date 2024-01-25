class InfoModel  {
  final String? id;
  final String firstname;
  final String lastname;
  final String email;
  final int phoneno;
  final String address;

  InfoModel({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneno,
    required this.address,
  });
  toJson(){
    return{
      "id":id,
      "First Name":  firstname,
      "Last Name" : lastname,
      "Email": email,
      "Phone No." : phoneno,
      "Adress": address,
    };
  }
}