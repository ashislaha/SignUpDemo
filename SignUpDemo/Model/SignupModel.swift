//
//  SignupModel.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import Foundation

enum FieldType {
	case none
	case firstName
	case lastName
	case email
	case password
	case website
	
	var placeHolderText: String {
		switch self {
		case .none: return ""
		case .firstName: return "First Name"
		case .lastName: return "Last Name"
		case .email: return "Email"
		case .password: return "Password"
		case .website: return "Website"
		}
	}
	
	var isMandatory: Bool {
		switch self {
		case .email, .password: return true
		default: return false
		}
	}
}

struct User {
	let avatarImageData: Data
	let identity: UserIdentity
}

struct UserIdentity {
	let firstName: String?
	let lastName: String?
	let email: String
	let encryptedPassword: String
	let website: String?
}
