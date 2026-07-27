.PHONY: lint format test component-test unit-test example-test verify publish-dry-run

lint:
	flutter analyze

format:
	dart format .

format-check:
	dart format --set-exit-if-changed .

component-test:
	flutter test test/component/*_test.dart

unit-test:
	flutter test test/unit/*_test.dart

test:
	flutter test

example-test:
	cd example && flutter test

publish-dry-run:
	flutter pub publish --dry-run

verify: format-check lint test example-test publish-dry-run
