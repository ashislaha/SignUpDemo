//
//  SignUpViewModelUnitTests.swift
//  SignUpDemoTests
//
//  Created by Ashis Laha on 16/01/22.
//

import XCTest
@testable import SignUpDemo

class SignUpViewModelUnitTests: XCTestCase {

	// Mock implementation of Sign Up Service Provider
	private struct MockSignUpServiceProvider: SignUpService {
		
		func signUpSubmitRequest(user: User, completionHandler: @escaping (Bool, String?) -> Void) {
			
			guard !user.identity.email.isEmpty && !user.identity.encryptedPassword.isEmpty else {
				completionHandler(false, "Email or Password is empty")
				return
			}
			
			completionHandler(true, nil) /* Success */
		}
	}
	
	private var viewModel: SignupViewModel!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		let mockSignUpServiceProvider = MockSignUpServiceProvider()
		viewModel = SignupViewModel(signUpService: mockSignUpServiceProvider)
		
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	

	func test_validate_signupviewModel_isAllValuesPresent_password_missing() {
		
		// email and password are mandatory field
		viewModel.userInfo = [
			.email: "aslaha@microsoft.com"
		]
		let result1 = viewModel.isAllValuesPresent()
		XCTAssertFalse(result1.0)
		XCTAssertEqual(result1.1, .password)
	}

	func test_validate_signupviewModel_isAllValuesPresent_email_missing() {
		
		// email and password are mandatory field
		viewModel.userInfo = [
			.password: "Aa1@$"
		]
		let result1 = viewModel.isAllValuesPresent()
		XCTAssertFalse(result1.0)
		XCTAssertEqual(result1.1, .email)
	}
	
	func test_validate_signupviewModel_isAllValuesPresent_success() {
		// email and password are mandatory field
		viewModel.userInfo = [
			.password: "Aa1@$",
			.email: "aslaha@microsoft.com"
		]
		let result1 = viewModel.isAllValuesPresent()
		XCTAssertTrue(result1.0)
		XCTAssertEqual(result1.1, .none)
	}
	
	func test_validate_signupviewModel_getUserIdentity_nil_object() {
		// as email and password are mandatory field, if any of them is missing, it should return nil
		viewModel.userInfo = [
			.password: "Aa1@$",
		]
		let result1 = viewModel.getUserIdentity()
		XCTAssertNil(result1)
		
		
		viewModel.userInfo = [
			.email: "aslaha@microsoft.com",
		]
		let result2 = viewModel.getUserIdentity()
		XCTAssertNil(result2)
		
		viewModel.userInfo = [:]
		let result3 = viewModel.getUserIdentity()
		XCTAssertNil(result3)
	}
	
	func test_validate_signupviewModel_getUserIdentity_valid_object() {
		// as email and password are mandatory field, if any of them is missing, it should return nil
		viewModel.userInfo = [
			.email: "ashislaha@microsoft.com",
			.password: "Aa1@$"
		]
		let result1 = viewModel.getUserIdentity()
		XCTAssertNotNil(result1)
		
		viewModel.userInfo = [
			.firstName: "Ashis",
			.lastName: "Laha",
			.email: "ashislaha@microsoft.com",
			.password: "Aa1@$"
		]
		let result2 = viewModel.getUserIdentity()
		XCTAssertNotNil(result2)
	}
	
	func test_validate_signupviewModel_signupservice_signup_submit_success() {
		let user = User(avatarImageData: Data(),
						identity: UserIdentity(firstName: "Ashis",
											   lastName: "Laha",
											   email: "aslaha@microsoft.com",
											   encryptedPassword: "A1@aq",
											   website: "Linked"))
		
		let expection = self.expectation(description: "signup_submit_success")
		
		// using Mock sign up service provider
		viewModel.signUpServiceProvider.signUpSubmitRequest(user: user) { isSuccess, errorString in
			XCTAssertTrue(isSuccess)
			XCTAssertNil(errorString)
			expection.fulfill()
		}
		
		waitForExpectations(timeout: 1.0, handler: nil)
	}
	
	func test_validate_signupviewModel_signupservice_signup_submit_failure() {
		
		// email is empty
		let user = User(avatarImageData: Data(),
						identity: UserIdentity(firstName: "Ashis",
											   lastName: "Laha",
											   email: "",
											   encryptedPassword: "A1@aq",
											   website: "Linked"))
		
		let expection = self.expectation(description: "signup_submit_failure")
		
		// using Mock sign up service provider
		viewModel.signUpServiceProvider.signUpSubmitRequest(user: user) { isSuccess, errorString in
			XCTAssertFalse(isSuccess)
			XCTAssertNotNil(errorString)
			XCTAssertEqual(errorString!, "Email or Password is empty")
			expection.fulfill()
		}
		
		waitForExpectations(timeout: 1.0, handler: nil)
	}
}
