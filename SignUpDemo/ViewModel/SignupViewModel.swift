//
//  SignupViewModel.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import Foundation

class SignupViewModel {
	
	let fields: [FieldType] = [.firstName, .lastName, .email, .password, .website]
	
	/// it will be used to save the field data
	var userInfo: [FieldType: String] = [:]
	
	/// validate whether all mandatory fields are present
	/// Return true if all fields are satisfying the correct value, false if not and return which first incorrect field type to notify to the user.
	func isAllValuesPresent() -> (Bool, FieldType)  {
		for each in fields {
			if userInfo[each] == nil {
				return (false, each)
			}
		}
		
		return (true, .none)
	}
	
	/// convert userInfo data into UserIdentity before sending the "sign up" request.
	func getUserIdentity() -> UserIdentity? {
		guard let firstName = userInfo[.firstName],
			  let lastName = userInfo[.lastName],
			  let email = userInfo[.email],
			  let password = userInfo[.password],
			  let website = userInfo[.website]
		else {
			return nil
		}
		
		return UserIdentity(firstName: firstName,
							lastName: lastName,
							email: email,
							encryptedPassword: password,
							website: website)
	}
	
	/// Sign up a User
	/// - Parameters:
	///   - user: an Instance of User
	///   - completionHandler: Pass true / false based on User creation state. Send Error message if something went wrong.
	func signUpSubmitRequest(user: User, completionHandler: @escaping (Bool, String?) -> Void) {
		
		// construct request body
		let bodyDict: [String: Any] = [
			"firstName": user.identity.firstName,
			"lastName": user.identity.lastName,
			"email": user.identity.email,
			"password": user.identity.encryptedPassword,
			"website": user.identity.website
		]
		NetworkLayer.postRequest(urlString: NetworkEndPoint.signup.urlString,
								 bodyDict: bodyDict,
								 requestType: .POST) { responseDict in
			
			// validation check (request email id must be same as response email id)
			if let responseDataDict = responseDict["data"] as? [String: Any],
				let responseEmail = responseDataDict["email"] as? String,
			   responseEmail == user.identity.email {
				
				completionHandler(true /* success */, nil /* no error message */)
			} else {
				completionHandler(false, "Invalid user")
			}
			
		} failureBlock: { errorString in
			completionHandler(false /* failure */, errorString)
		}

	}
	
}
