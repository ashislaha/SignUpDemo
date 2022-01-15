//
//  FieldValidation.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 15/01/22.
//

import Foundation

struct FieldValidation {
	
	/// Validate each field type whether the input text satisfies all the constraints.
	/// - Parameters:
	///   - type: what type of field it is.
	///   - inputText: input text associated with type.
	func validateField(type: FieldType, inputText: String) -> (Bool, String?) {
		
		// we are using a regualar expression to validate a field.
		// https://rubular.com/r/UAwoaPM0Ji helps to understand the RegEx.
		
		// no validation
		var defaultValue: (Bool, String?) = (true, nil)
		
		switch type {
		case .firstName, .lastName:
			let name = inputText.trimmingCharacters(in: CharacterSet.whitespaces)
			let nameRegx = "^[a-zA-Z].*[a-zA-Z]$"
			let nameCheck = NSPredicate(format: "SELF MATCHES %@", nameRegx)
			if !nameCheck.evaluate(with: name) {
				defaultValue = (false, "At least 2 letter, No digit")
			}
		case .email:
			let email = inputText.trimmingCharacters(in: CharacterSet.whitespaces)
			let emailRegx = "^[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}$"
			let emailCheck = NSPredicate(format: "SELF MATCHES %@", emailRegx)
			if !emailCheck.evaluate(with: email) {
				defaultValue = (false, "<name>@<host>.<domain>")
			}
			
		case .website:
			let website = inputText.trimmingCharacters(in: CharacterSet.whitespaces)
			let websiteRegx = "^[a-zA-Z0-9].*[a-zA-Z0-9]$"
			let websiteCheck = NSPredicate(format: "SELF MATCHES %@", websiteRegx)
			if !websiteCheck.evaluate(with: website) {
				defaultValue = (false, "Support UpperCase, Lowercase and digit")
			}
		case .password:
			// least one uppercase,
			// least one digit
			// least one lowercase
			// least one symbol
			// 5 characters
			let password = inputText.trimmingCharacters(in: CharacterSet.whitespaces)
			let passwordRegx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{5}$"
			let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
			if !passwordCheck.evaluate(with: password) {
				defaultValue = (false, "5 chars -> 1 (upper, lower, digit, symbol)")
			}
			break
		case .none:
			break
		}
		
		return defaultValue
	}
}
