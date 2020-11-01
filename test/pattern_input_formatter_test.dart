import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

void main() {
  group('numeric formatter smoke test', _numericFormatterSmokeTest);

  group('date formatter smoke test', _dateFormatterSmokeTest);
}

const kNonBreakingSpace = '\xa0';

_numericFormatterSmokeTest() {
  final ThousandsFormatter thousandsFormatter =
      ThousandsFormatter(formatter: NumberFormat.decimalPattern('en_US'));
  final ThousandsFormatter thousandsRusFormatter =
      ThousandsFormatter(formatter: NumberFormat.decimalPattern('ru'));
  final ThousandsFormatter decimalFormatter = ThousandsFormatter(
      formatter: NumberFormat.decimalPattern('en_US'), allowFraction: true);
  final decimalRusFormatter = ThousandsFormatter(
      formatter: NumberFormat.decimalPattern('ru'), allowFraction: true);
  final CreditCardFormatter creditCardFormatter = CreditCardFormatter();

  test('numeric filter smoke test', () {
    final newValue1 = thousandsFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12a', selection: TextSelection.collapsed(offset: 3)));

    final newValue2 = creditCardFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12a', selection: TextSelection.collapsed(offset: 3)));

    final newValue3 = decimalFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12a', selection: TextSelection.collapsed(offset: 3)));

    expect(newValue1.text, equals('12'));

    expect(newValue2.text, equals('12'));

    expect(newValue3.text, equals('12'));
  });

  test('thousands grouping smoke test rus', () {
    /*final newValue = thousandsRusFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12a', selection: TextSelection.collapsed(offset: 3)));

    expect(newValue.text, equals('12'));

    final newValue1 = thousandsRusFormatter.formatEditUpdate(
        TextEditingValue(
            text: '123', selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue(
            text: '1234', selection: TextSelection.collapsed(offset: 4)));

    expect(
        newValue1,
        TextEditingValue(
            text: '1${kNonBreakingSpace}234',
            selection: TextSelection.collapsed(offset: 5)));*/

    final newValue2 = decimalRusFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12,', selection: TextSelection.collapsed(offset: 3)));

    expect(
        newValue2,
        TextEditingValue(
            text: '12,', selection: TextSelection.collapsed(offset: 3)));

    final newValue4 = decimalRusFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1${kNonBreakingSpace}234',
            selection: TextSelection.collapsed(offset: 5)),
        TextEditingValue(
            text: '1${kNonBreakingSpace}234,',
            selection: TextSelection.collapsed(offset: 6)));

    expect(newValue4.text, equals('1${kNonBreakingSpace}234,'));

    final newValue5 = decimalRusFormatter.formatEditUpdate(
        newValue4,
        TextEditingValue(
            text: '1${kNonBreakingSpace}234,5',
            selection: TextSelection.collapsed(offset: 7)));

    expect(newValue5.text, equals('1${kNonBreakingSpace}234,5'));

    final newValue6 = decimalRusFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1${kNonBreakingSpace}234,5',
            selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue(
            text: '1${kNonBreakingSpace}2134,5',
            selection: TextSelection.collapsed(offset: 4)));

    expect(
        newValue6,
        equals(TextEditingValue(
            text: '12${kNonBreakingSpace}134,5',
            selection: TextSelection.collapsed(offset: 4))));

    final newValue7 = decimalRusFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1${kNonBreakingSpace}234,55',
            selection: TextSelection.collapsed(offset: 8)),
        TextEditingValue(
            text: '1${kNonBreakingSpace}234,556',
            selection: TextSelection.collapsed(offset: 9)));

    expect(
        newValue7,
        TextEditingValue(
            text: '1${kNonBreakingSpace}234,55',
            selection: TextSelection.collapsed(offset: 8)));
  });

  test('thousands grouping smoke test', () {
    final newValue1 = thousandsFormatter.formatEditUpdate(
        TextEditingValue(
            text: '123', selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue(
            text: '1234', selection: TextSelection.collapsed(offset: 4)));

    expect(
        newValue1,
        TextEditingValue(
            text: '1,234', selection: TextSelection.collapsed(offset: 5)));

    final newValue2 = thousandsFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12.', selection: TextSelection.collapsed(offset: 3)));

    expect(newValue2.text, equals('12'));

    final newValue3 = decimalFormatter.formatEditUpdate(
        TextEditingValue(
            text: '12', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12.', selection: TextSelection.collapsed(offset: 3)));

    expect(newValue3.text, equals('12.'));

    final newValue4 = decimalFormatter.formatEditUpdate(
        newValue1,
        TextEditingValue(
            text: '1,234.', selection: TextSelection.collapsed(offset: 6)));

    expect(newValue4.text, equals('1,234.'));

    final newValue5 = decimalFormatter.formatEditUpdate(
        newValue4,
        TextEditingValue(
            text: '1,234.5', selection: TextSelection.collapsed(offset: 7)));

    expect(newValue5.text, equals('1,234.5'));

    final newValue6 = decimalFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1,234.5', selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue(
            text: '1,2134.5', selection: TextSelection.collapsed(offset: 4)));

    expect(
        newValue6,
        equals(TextEditingValue(
            text: '12,134.5', selection: TextSelection.collapsed(offset: 4))));

    final newValue7 = decimalFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1,234.55', selection: TextSelection.collapsed(offset: 8)),
        TextEditingValue(
            text: '1,234.556', selection: TextSelection.collapsed(offset: 9)));

    expect(
        newValue7,
        TextEditingValue(
            text: '1,234.55', selection: TextSelection.collapsed(offset: 8)));
  });

  test('numeric grouping rus locale test', () {});
  test('credit card number grouping smoke test', () {
    final newValue1 = creditCardFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1234', selection: TextSelection.collapsed(offset: 4)),
        TextEditingValue(
            text: '12345', selection: TextSelection.collapsed(offset: 5)));

    expect(
        newValue1,
        TextEditingValue(
            text: '1234 5', selection: TextSelection.collapsed(offset: 6)));

    final newValue2 = creditCardFormatter.formatEditUpdate(
        TextEditingValue(
            text: '1234 5', selection: TextSelection.collapsed(offset: 2)),
        TextEditingValue(
            text: '12134 5', selection: TextSelection.collapsed(offset: 3)));

    expect(
        newValue2,
        equals(TextEditingValue(
            text: '1213 45', selection: TextSelection.collapsed(offset: 3))));
  });
}

_dateFormatterSmokeTest() {
  final formatter = DateInputFormatter();

  test('date form input smoke test', () {
    // test insert placeholder when user start editing
    final newValue1 = formatter.formatEditUpdate(
        TextEditingValue(
            text: '', selection: TextSelection.collapsed(offset: 0)),
        TextEditingValue(
            text: '', selection: TextSelection.collapsed(offset: 0)));
    expect(
        newValue1,
        TextEditingValue(
            text: '--/--/----', selection: TextSelection.collapsed(offset: 0)));

    // test add a new digit at start position
    final newValue2 = formatter.formatEditUpdate(
        newValue1,
        TextEditingValue(
            text: '1--/--/----',
            selection: TextSelection.collapsed(offset: 1)));
    expect(
        newValue2,
        TextEditingValue(
            text: '1-/--/----', selection: TextSelection.collapsed(offset: 1)));

    // test add a new digit in the middle
    final newValue3 = formatter.formatEditUpdate(
        newValue2.copyWith(selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue(
            text: '1-/2--/----',
            selection: TextSelection.collapsed(offset: 4)));
    expect(
        newValue3,
        TextEditingValue(
            text: '1-/2-/----', selection: TextSelection.collapsed(offset: 4)));

    // test delete
    final newValue4 = formatter.formatEditUpdate(
        newValue3,
        TextEditingValue(
            text: '1-/-/----', selection: TextSelection.collapsed(offset: 3)));
    expect(
        newValue4,
        TextEditingValue(
            text: '1-/--/----', selection: TextSelection.collapsed(offset: 2)));

    // test restrict input length
    final newValue5 = formatter.formatEditUpdate(
        TextEditingValue(
            text: '12/12/2018', selection: TextSelection.collapsed(offset: 10)),
        TextEditingValue(
            text: '12/12/20180',
            selection: TextSelection.collapsed(offset: 11)));
    expect(
        newValue5,
        TextEditingValue(
            text: '12/12/2018',
            selection: TextSelection.collapsed(offset: 10)));

    // test delete when cursor stands right after splash
    final newValue6 = formatter.formatEditUpdate(
        TextEditingValue(
            text: '12/12/2018', selection: TextSelection.collapsed(offset: 3)),
        TextEditingValue(
            text: '1212/2018', selection: TextSelection.collapsed(offset: 2)));
    expect(
        newValue6,
        TextEditingValue(
            text: '12/12/2018', selection: TextSelection.collapsed(offset: 2)));
  });
}
