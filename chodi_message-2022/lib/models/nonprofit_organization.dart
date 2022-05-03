import 'package:cloud_firestore/cloud_firestore.dart';

class NonProfitOrg {
  String ein;
  String name;
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
  String? impactImageURL;
  int? founded;
  int? zip;
  int? orgSize;
  //may add more

  NonProfitOrg(
      {required this.ein,
      required this.name,
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
      this.impactImageURL,
      this.founded,
      this.zip,
      this.orgSize});

  returnImpactImageURL() {
    return impactImageURL;
  }

  returnEIN() {
    return ein;
  }

  returnName() {
    return name ;
  }


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
      impactImageURL: data['impactImageURL'] ?? '',
      founded: data['Founded'] ?? 0,
      zip: data['Zip'] ?? 0,
      orgSize: data['Org Size'] ?? 0,
    );
  }
}

Future<List<NonProfitOrg>> getAllNonprofits() async {
  QuerySnapshot ngoList = 
      await FirebaseFirestore.instance.collection("Nonprofits").get();

  return ngoList.docs.map(
      (data) => NonProfitOrg(
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
        impactImageURL: data['impactImageURL'] ?? '',
        founded: data['Founded'] ?? 0,
        zip: data['Zip'] ?? 0,
        orgSize: data['Org Size'] ?? 0,
      )
  ).toList() ;
}

NonProfitOrg getNonProfit(List<NonProfitOrg> list, String EIN) {
  for (int i = 0 ; i < list.length ; i++){
    if (list[i].ein == EIN) {
      return list[i] ;
    }
  }
  throw UnimplementedError();
}