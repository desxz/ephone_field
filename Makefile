component-test:
	flutter test test/component/*_test.dart

unit-test:
	flutter test test/unit/*_test.dart

test: unit-test component-test