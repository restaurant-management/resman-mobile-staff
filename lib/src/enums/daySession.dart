import 'baseEnum.dart';

class DaySession extends BaseEnum {
  static final DaySession none = DaySession('none');
  static final DaySession morning = DaySession('morning');
  static final DaySession noon = DaySession('noon');
  static final DaySession afternoon = DaySession('afternoon');
  static final DaySession evening = DaySession('evening');

  DaySession(String value)
      : super(value, [
    'none',
    'morning',
    'noon',
    'afternoon',
    'evening',
  ]);
}