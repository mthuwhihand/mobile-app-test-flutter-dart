import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_test/utils/validators.dart';

void main() {
  group('Validators', () {
    test('isValidEmail returns true for valid email', () {
      expect(Validators.isValidEmail('test@example.com'), isTrue);
      expect(Validators.isValidEmail('user.name@domain.co'), isTrue);
      expect(Validators.isValidEmail('user123123@domain.co'), isTrue);
    });

    test('isValidEmail returns false for invalid email', () {
      expect(Validators.isValidEmail('test.com'), isFalse);
      expect(Validators.isValidEmail('user@domain'), isFalse);
      expect(Validators.isValidEmail('user@.com'), isFalse);
      expect(Validators.isValidEmail('@domain.com'), isFalse);
      expect(Validators.isValidEmail('user@domain..com'), isFalse);
    });

    test('isValidPassword returns true for valid password', () {
      expect(Validators.isValidPassword('Password1'), isTrue);
      expect(Validators.isValidPassword('Valid123'), isTrue);
      expect(Validators.isValidPassword('A1b2C3d'), isTrue);
    });

    test('isValidPassword returns false for invalid password', () {
      expect(Validators.isValidPassword('password'), isFalse); // No uppercase or digit
      expect(Validators.isValidPassword('PASSWORD'), isFalse); // No digit
      expect(Validators.isValidPassword('123456'), isFalse);  // No letter
      expect(Validators.isValidPassword('Pass1'), isFalse);   // Less than 6 characters
      expect(Validators.isValidPassword('password123'), isFalse); // No uppercase letter
    });
  });
}