//
//  FieldValidationUnitTests.swift
//  SignUpDemoTests
//
//  Created by Ashis Laha on 16/01/22.
//

import XCTest
@testable import SignUpDemo

class FieldValidationUnitTests: XCTestCase {

	func test_validate_field_with_invalid_user_first_name() {
		
		let fieldValidation = FieldValidation()
		
		let result1 = fieldValidation.validateField(type: .firstName, inputText: "Ashis123")
		XCTAssertFalse(result1.0)
		XCTAssertEqual(result1.1, "At least 2 letter, No digit")
		
		let result2 = fieldValidation.validateField(type: .firstName, inputText: "P")
		XCTAssertFalse(result2.0)
		XCTAssertEqual(result2.1, "At least 2 letter, No digit")
		
		let result3 = fieldValidation.validateField(type: .firstName, inputText: "456")
		XCTAssertFalse(result3.0)
		XCTAssertEqual(result3.1, "At least 2 letter, No digit")
	}
	
	func test_validate_field_with_valid_user_first_name() {
		
		let fieldValidation = FieldValidation()
		
		// as first_name is an optional entry, an empty string is allowed for our use-case
		let result1 = fieldValidation.validateField(type: .firstName, inputText: "")
		XCTAssertTrue(result1.0)
		XCTAssertNil(result1.1)
		
		let result2 = fieldValidation.validateField(type: .firstName, inputText: "Ashis")
		XCTAssertTrue(result2.0)
		XCTAssertNil(result2.1)

		let result3 = fieldValidation.validateField(type: .firstName, inputText: "Mr. Ashis")
		XCTAssertTrue(result3.0)
		XCTAssertNil(result3.1)
	}
	
	func test_validate_field_with_invalid_user_last_name() {
		let fieldValidation = FieldValidation()
		
		let result1 = fieldValidation.validateField(type: .lastName, inputText: "Laha 222")
		XCTAssertFalse(result1.0)
		XCTAssertEqual(result1.1, "At least 2 letter, No digit")
		
		let result2 = fieldValidation.validateField(type: .lastName, inputText: "L")
		XCTAssertFalse(result2.0)
		XCTAssertEqual(result2.1, "At least 2 letter, No digit")
		
		let result3 = fieldValidation.validateField(type: .lastName, inputText: "456")
		XCTAssertFalse(result3.0)
		XCTAssertEqual(result3.1, "At least 2 letter, No digit")
	}
	
	func test_validate_field_with_valid_user_last_name() {
		let fieldValidation = FieldValidation()
		
		// as last_name is an optional entry, an empty string is allowed for our use-case
		let result1 = fieldValidation.validateField(type: .lastName, inputText: "")
		XCTAssertTrue(result1.0)
		XCTAssertNil(result1.1)
		
		let result2 = fieldValidation.validateField(type: .lastName, inputText: "Laha")
		XCTAssertTrue(result2.0)
		XCTAssertNil(result2.1)
	}

	func test_validate_field_with_invalid_user_email() {
		
		let fieldValidation = FieldValidation()
		
		// email is a mandatory field, app should not allow an empty string.
		let result1 = fieldValidation.validateField(type: .email, inputText: "")
		XCTAssertFalse(result1.0)
		XCTAssertEqual(result1.1, "<name>@<domain>")
		
		let result2 = fieldValidation.validateField(type: .email, inputText: "abcd")
		XCTAssertFalse(result2.0)
		XCTAssertEqual(result2.1, "<name>@<domain>")
		
		let result3 = fieldValidation.validateField(type: .email, inputText: "ashis@microsoft")
		XCTAssertFalse(result3.0)
		XCTAssertEqual(result3.1, "<name>@<domain>")
		
		let result4 = fieldValidation.validateField(type: .email, inputText: "@microsoft.com")
		XCTAssertFalse(result4.0)
		XCTAssertEqual(result4.1, "<name>@<domain>")
	}
	
	func test_validate_field_with_valid_user_email() {
		let fieldValidation = FieldValidation()
		
		let result1 = fieldValidation.validateField(type: .email, inputText: "aslaha@microsoft.com")
		XCTAssertTrue(result1.0)
		XCTAssertNil(result1.1)
		
		let result2 = fieldValidation.validateField(type: .email, inputText: "aslaha@microsoft.co.in")
		XCTAssertTrue(result2.0)
		XCTAssertNil(result2.1)
		
		let result3 = fieldValidation.validateField(type: .email, inputText: "ashis123@microsoft.com")
		XCTAssertTrue(result3.0)
		XCTAssertNil(result3.1)
		
		let result4 = fieldValidation.validateField(type: .email, inputText: "a@microsoft123.com")
		XCTAssertTrue(result4.0)
		XCTAssertNil(result4.1)
	}
	
	func test_validate_field_with_invalid_user_password() {
		
		let fieldValidation = FieldValidation()
		
		// Password is a mandatory field.
		// least one uppercase,
		// least one digit
		// least one lowercase
		// least one symbol
		// 5 characters
		let result1 = fieldValidation.validateField(type: .password, inputText: "")
		XCTAssertFalse(result1.0)
		XCTAssertEqual(result1.1, "5 chars -> 1 (upper, lower, digit, symbol)")
		
		let result2 = fieldValidation.validateField(type: .password, inputText: "abcd")
		XCTAssertFalse(result2.0)
		XCTAssertEqual(result2.1, "5 chars -> 1 (upper, lower, digit, symbol)")
		
		let result3 = fieldValidation.validateField(type: .password, inputText: "ashis@microsoft")
		XCTAssertFalse(result3.0)
		XCTAssertEqual(result3.1, "5 chars -> 1 (upper, lower, digit, symbol)")
		
		let result4 = fieldValidation.validateField(type: .password, inputText: "12345")
		XCTAssertFalse(result4.0)
		XCTAssertEqual(result4.1, "5 chars -> 1 (upper, lower, digit, symbol)")
	}
	
	func test_validate_field_with_valid_user_password() {
		
		let fieldValidation = FieldValidation()
		
		let result1 = fieldValidation.validateField(type: .password, inputText: "Aa1@b")
		XCTAssertTrue(result1.0)
		XCTAssertNil(result1.1)
		
		let result2 = fieldValidation.validateField(type: .password, inputText: "AA1@a")
		XCTAssertTrue(result2.0)
		XCTAssertNil(result2.1)
		
		let result3 = fieldValidation.validateField(type: .password, inputText: "1@aA1")
		XCTAssertTrue(result3.0)
		XCTAssertNil(result3.1)
		
		let result4 = fieldValidation.validateField(type: .password, inputText: "1aA$@")
		XCTAssertTrue(result4.0)
		XCTAssertNil(result4.1)
	}
	
}
