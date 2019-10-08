import 'baseEnum.dart';

class Permission extends BaseEnum {
  static final Permission roleManagement = Permission('role-management');
  static final Permission userManagement = Permission('user-management');
  static final Permission billManagement = Permission('bill-management');
  static final Permission createBill = Permission('create-bill');
  static final Permission updatePaidBillStatus =
  Permission('update-paid-bill-status');
  static final Permission updatePreparingBillStatus =
  Permission('update-preparing-bill-status');
  static final Permission updatePrepareDoneBillStatus =
  Permission('update-prepare-done-bill-status');
  static final Permission updateDeliveringBillStatus =
  Permission('update-delivering-bill-status');
  static final Permission updateShippingBillStatus =
  Permission('update-shipping-bill-status');
  static final Permission updateCompleteBillStatus =
  Permission('update-Complete-bill-status');
  static final Permission dishManagement = Permission('dish-management');
  static final Permission dailyDishManagement =
  Permission('daily-dish-management');

  Permission(String value)
      : super(value, [
    'role-management',
    'user-management',
    'bill-management',
    'create-bill',
    'update-preparing-bill-status',
    'update-paid-bill-status',
    'update-prepare-done-bill-status',
    'update-delivering-bill-status',
    'update-shipping-bill-status',
    'update-Complete-bill-status',
    'dish-management',
    'daily-dish-management'
  ]);

  static List<Permission> fromListString(List<String> stringPermissions) {
    if (stringPermissions == [] || stringPermissions == null) return [];
    List<Permission> result =
    stringPermissions.map((item) => Permission(item)).toList();
    result.removeWhere((item) => item == null || item.toString().isEmpty);
    return result;
  }
}
