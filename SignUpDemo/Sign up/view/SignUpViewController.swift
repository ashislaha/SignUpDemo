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
		
		createAvatarView()
		createSubmitButton()
		
		view.addSubview(activityIndicator)
		activityIndicator.anchors(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tableView.addGestureRecognizer(tapGesture)
	}
	
	// MARK: Private APIs and properties
	
	private let viewModel = SignupViewModel()
	
	private var isAvatarAvailable: Bool = false
	private var avatarImage: UIImage?
	
	@objc private func dismissKeyboard() {
		tableView.endEditing(true)
	}
	
	private func createAvatarView() {
		let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 150))
		let avatarView = AvatarView()
		headerView.addSubview(avatarView)
		avatarView.fillSuperView()
		avatarView.delegate = self
		tableView.tableHeaderView = headerView
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
	
	private let activityIndicator: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView()
		spinner.style = .large
		spinner.color = .orange
		spinner.hidesWhenStopped = true
		return spinner
	}()
	
	@objc private func signup() {
		
		let isValid = viewModel.isAllValuesPresent()
		
		if isValid.0 && isAvatarAvailable {
			
			guard let userIdentity = viewModel.getUserIdentity(),
				  let imageData = avatarImage?.pngData()
			else { return }
			
			let user = User(avatarImageData: imageData, identity: userIdentity)
			activityIndicator.startAnimating()
			
			viewModel.signUpSubmitRequest(user: user) { [weak self] isSuccess, failureMessage in
				DispatchQueue.main.async {
					
					self?.activityIndicator.stopAnimating()
					
					if isSuccess {
						self?.showAlert(title: "Success",
										message: "Sign up Successfull",
										buttonTitle: "Okay") { _ in
							
							let userDetailsController = ConfirmationWithUserDetailsViewController()
							userDetailsController.user = user
							self?.navigationController?.pushViewController(userDetailsController, animated: true)
							//self?.present(userDetailsController, animated: true, completion: nil)
							
						}
					} else {
						self?.showAlert(title: "Failure",
										message: "Error in sign up flow: " + (failureMessage ?? ""),
										buttonTitle: "Okay")
					}
				}
			}
		} else {
			
			if !isAvatarAvailable {
				showAlert(title: "Failure",
						  message: "Please add an avatar",
						  buttonTitle: "Okay")
				
			} else {
				showAlert(title: "Failure",
						  message: "Please fill \(isValid.1.placeHolderText) field",
						  buttonTitle: "Okay")
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

// MARK: SignUpTableViewCellDelegate
extension SignUpTableViewController: SignUpTableViewCellDelegate {
	
	func fieldViewDidBeginInteracting(_ cell: SignUpTableViewCell, type: FieldType) {
		// this can be used for telemetry/events, no use in our current scope
	}
	
	func fieldViewDidEndInteracting(_ cell: SignUpTableViewCell, type: FieldType, value: String) {
		viewModel.userInfo[type] = value
	}
	
	func fieldViewValidationError(_ cell: SignUpTableViewCell, type: FieldType) {
		// remove stale entry (if needed)
		viewModel.userInfo.removeValue(forKey: type)
	}
}

// MARK: AvatarViewDelegate
extension SignUpTableViewController: AvatarViewDelegate {
	
	func avatarPicked(_ view: AvatarView, image: UIImage) {
		isAvatarAvailable = true
		avatarImage = image
	}
	
	func parentController() -> UIViewController {
		return self
	}
}
