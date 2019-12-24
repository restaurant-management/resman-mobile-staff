class GraphQuery {
  static String changeProfile(
      {String avatar,
      String fullName,
      String phoneNumber,
      DateTime birthday,
      String address}) {
    return '''
    mutation {
      changeProfileAsUser(
        ${avatar != null ? ' avatar: "$avatar"' : ''}, 
        ${fullName != null ? ' fullName: "$fullName"' : ''}, 
        ${phoneNumber != null ? ' phoneNumber: "$phoneNumber"' : ''},
        ${birthday != null ? ' birthday: "$birthday"' : ''}
        ${address != null ? ' address: "$address"' : ''}
      ) {
        uuid
      }
    }
    ''';
  }

  static String getAllBillStaff() {
    return '''
    {
      totalAllBillsByStaff(
     
      ) {
        uuid
      }
    }
    ''';
  }
}
