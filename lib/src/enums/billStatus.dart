import 'baseEnum.dart';

class BillStatus extends BaseEnum {
  static final BillStatus created = BillStatus('created');
  static final BillStatus paid = BillStatus('paid');
  static final BillStatus preparing = BillStatus('preparing');
  static final BillStatus prepareDone = BillStatus('prepare-done');
  static final BillStatus delivering = BillStatus('delivering');
  static final BillStatus shipping = BillStatus('shipping');
  static final BillStatus complete = BillStatus('complete');

  BillStatus(String value)
      : super(value, [
          'created',
          'paid',
          'preparing',
          'prepare-done',
          'delivering',
          'shipping',
          'complete',
        ]);
}
