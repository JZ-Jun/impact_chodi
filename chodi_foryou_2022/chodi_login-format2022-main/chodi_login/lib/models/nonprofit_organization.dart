import 'package:cloud_firestore/cloud_firestore.dart';

class NonProfitOrg {
  String? ein;
  String? name;
  String? category;
  String? cause;
  String? city;
  String? state;
  String? website;
  String? financials;
  String? address;
  String? contactEmail;
  String? contactFirstName;
  String? contactLastName;
  String? contactNumber;
  String? vision;
  String? imageURL;
  int? founded;
  int? zip;
  int? orgSize;
  //may add more

  NonProfitOrg(
      {this.ein,
      this.name,
      this.category,
      this.cause,
      this.city,
      this.state,
      this.website,
      this.financials,
      this.address,
      this.contactEmail,
      this.contactFirstName,
      this.contactLastName,
      this.contactNumber,
      this.vision,
      this.imageURL,
      this.founded,
      this.zip,
      this.orgSize});

  factory NonProfitOrg.fromFirestore(QueryDocumentSnapshot fbData) {
    Map data = fbData.data() as Map;

    return NonProfitOrg(
      ein: data['EIN'] ?? '',
      name: data['Name'] ?? '',
      category: data['Category'] ?? '',
      cause: data['Cause'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      website: data['Website'] ?? '',
      financials: data['Financials'] ?? '',
      address: data['Address'] ?? '',
      contactEmail: data['Contact Email'] ?? '',
      contactFirstName: data['Contact First Name'] ?? '',
      contactLastName: data['Contact Last Name'] ?? '',
      contactNumber: data['Contact Number'] ?? '',
      vision: data['Mission/Vision'] ?? '',
      imageURL: data['imageURL'] ?? '',
      founded: data['Founded'] ?? 0,
      zip: data['Zip'] ?? 0,
      orgSize: data['Org Size'] ?? 0,
    );
  }
}
