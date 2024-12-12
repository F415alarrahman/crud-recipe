import 'package:flutter_test/flutter_test.dart';
import 'package:post_recipe/view/calculator.dart'; // Sesuaikan dengan path yang benar

void main() {
  test('should return the correct sum when adding two numbers', () {
    // Arrange
    final calculator = Calculator();

    // Act
    final result = calculator.add(2, 3);

    // Assert
    expect(result, 5);
  });

  test('should return the correct difference when subtracting two numbers', () {
    // Arrange
    final calculator = Calculator();

    // Act
    final result = calculator.subtract(5, 3);

    // Assert
    expect(result, 2);
  });
}
