//
//  SignupViewModel.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import Foundation

struct SignupViewModel {
	
	let fields: [FieldType] = [.firstName, .lastName, .email, .password, .website]
	
	let signUpServiceProvider: SignUpService
	
	/// it will be used to save the field data
	var userInfo: [FieldType: String] = [:]
	
	/// Init
	init(signUpService: SignUpService) {
		self.signUpServiceProvider = signUpService
	}
	
	/// validate whether all mandatory fields are present
	/// Return true if all fields are satisfying the correct value, false if not and return which first incorrect field type to notify to the user.
	func isAllValuesPresent() -> (Bool, FieldType)  {
		for each in fields {
			if each.isMandatory && userInfo[each] == nil {
				return (false, each)
			}
		}
		
		return (true, .none)
	}
	
	/// convert userInfo data into UserIdentity before sending the "sign up" request.
	func getUserIdentity() -> UserIdentity? {
		guard let email = userInfo[.email],
			  let password = userInfo[.password]
		else {
			return nil
		}
		
		return UserIdentity(firstName: userInfo[.firstName],
							lastName: userInfo[.lastName],
							email: email,
							encryptedPassword: password,
							website: userInfo[.website])
	}
}
