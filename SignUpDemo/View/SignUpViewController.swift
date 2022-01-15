//
//  ViewController.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import UIKit

class SignUpTableViewController: UITableViewController {

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Profile Creation"
		
		tableView.separatorStyle = .none
		tableView.register(SignUpTableViewCell.self, forCellReuseIdentifier: "cell")
		
		tableView.estimatedRowHeight = 44
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.estimatedSectionHeaderHeight = 200
		tableView.sectionHeaderHeight = UITableView.automaticDimension
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tableView.addGestureRecognizer(tapGesture)
		
		createSubmitButton()
	}
	
	// MARK: Private APIs and properties
	
	private let viewModel = SignupViewModel()
	
	@objc private func dismissKeyboard() {
		tableView.endEditing(true)
	}
	
	private func createSubmitButton() {
		let button = UIButton(frame: .init(x: 0, y: 0, width: tableView.bounds.width, height: 50))
		button.backgroundColor = .orange
		button.setTitle("Submit", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
		button.addTarget(self, action: #selector(signup), for: .touchUpInside)
		
		tableView.tableFooterView = button
	}
	
	@objc private func signup() {
		
		// validation first
		let isValid = viewModel.isAllValuesPresent()
		
		// TODO:- avatar retrieval logic is pending
		let isAvatarAvailable = true
		
		if isValid.0 && isAvatarAvailable {
			
			guard let userIdentity = viewModel.getUserIdentity() else { return }
			
			viewModel.signUpSubmitRequest(user: User(avatarUrl: URL(string: "abcd")!,
													 identity: userIdentity)) { isSuccess, failureMessage in
				if isSuccess {
					print("User signed up successfully")
				} else {
					print("Error in sign up flow: ", failureMessage ?? "")
				}
			}
		} else {
			
			if !isAvatarAvailable {
				print("Please add an avatar")
			} else {
				print("Please fill this field ", isValid.1.placeHolderText)
			}
		}
	}
	
}

// MARK: TableViewControllerDataSource
extension SignUpTableViewController {
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.fields.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SignUpTableViewCell
		cell.delegate = self
		cell.fieldType = viewModel.fields[indexPath.row]
		return cell
	}
}

extension SignUpTableViewController: SignUpTableViewCellDelegate {
	
	func fieldViewDidBeginInteracting(_ cell: SignUpTableViewCell, type: FieldType) {
		// this can be used for telemetry/events, no use in our current scope
	}
	
	func fieldViewDidEndInteracting(_ cell: SignUpTableViewCell, type: FieldType, value: String) {
		viewModel.userInfo[type] = value
	}
}

