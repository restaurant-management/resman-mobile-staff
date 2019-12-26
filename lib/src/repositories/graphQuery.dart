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

  static String getAllBillChef() {
    return '''
    {
  todayAllBillsByChef{
    bills {
      tableNumber,
      createAt,
      prepareAt,
      collectAt,
      collectValue,
      note,
    dishes{ quantity, dish {name, images, price}}
    }
  }
}
    ''';
  }
}
