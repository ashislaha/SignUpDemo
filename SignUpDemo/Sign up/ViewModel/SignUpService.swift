//
//  SignUpService.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 16/01/22.
//

import Foundation

protocol SignUpService {
	func signUpSubmitRequest(user: User, completionHandler: @escaping (Bool, String?) -> Void)
}

struct SignUpServiceProvider: SignUpService {
	
	/// Sign up a User
	/// - Parameters:
	///   - user: an Instance of User
	///   - completionHandler: Pass true / false based on User creation state. Send Error message if something went wrong.
	func signUpSubmitRequest(user: User, completionHandler: @escaping (Bool, String?) -> Void) {
		
		guard !user.identity.email.isEmpty && !user.identity.encryptedPassword.isEmpty else {
			completionHandler(false, "Email or Password is empty")
			return
		}
		
		// construct request body
		let bodyDict: [String: Any] = [
			"firstName": user.identity.firstName ?? "",
			"lastName": user.identity.lastName ?? "",
			"email": user.identity.email,
			"password": user.identity.encryptedPassword,
			"website": user.identity.website ?? ""
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
