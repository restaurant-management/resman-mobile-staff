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
      id,
      tableNumber,
      createAt,
      prepareAt,
      collectAt,
      collectValue,
      note,
    dishes{ quantity, price, dish {name, images}}
    }
  }
}
    ''';
  }

  static String prepareBill(int billId) {
    return '''
mutation{
  prepareBill(id: $billId)
  {
    id,
    tableNumber,
    createAt,
    prepareAt,
    collectAt,
    collectValue,
    voucherCode,
    voucherValue,
    discountCode,
    discountValue,
    rating,
    note,
    dishes {note, dish {images, name}}
  }
}
    ''';
  }

  static String getBillById(int billId) {
    return '''
query{
  getBill(id: $billId)
  {
    id,
    tableNumber,
    createAt,
    prepareAt,
    collectAt,
    collectValue,
    voucherCode,
    voucherValue,
    voucherIsPercent,
    discountCode,
    discountValue,
    rating,
    note,
    createBy
    {
      uuid,
      username,
      fullName,
      avatar,
      email,
      avatar,
      phoneNumber,
      birthday,
      roles {
        slug,
        name,
        description
      }
    },
    prepareBy
    {
      uuid,
      username,
      fullName,
      avatar,
      email,
      avatar,
      phoneNumber,
      birthday,
      roles {
        slug,
        name,
        description
      }
    },
    collectBy{
      uuid,
      username,
      fullName,
      avatar,
      email,
      avatar,
      phoneNumber,
      birthday,
      roles {
        slug,
        name,
        description
      }
    },
    dishes
    {
      dishId,
      note,
      preparedAt,
      deliveryAt,
      deliveryAt,
      quantity,
      price,
      dish {
        name,
        images,
        id,
      }
    }
    ,
  }
}
    ''';
  }
}
