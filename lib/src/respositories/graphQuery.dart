class GraphQuery
{
  static String changeProfile(
      {String avatar = '',
        String fullName = '',
        String phoneNumber = '',
        DateTime birthday,
        String address}) {
    return '''
    mutation {
      changeProfileAsUser(
        avatar: "$avatar", 
        fullName: "$fullName", 
        phoneNumber: "$phoneNumber", 
        ${birthday != null ? 'birthday: "$birthday"' : ''}
      ) {
        uuid
      }
    }
    ''';
  }
}