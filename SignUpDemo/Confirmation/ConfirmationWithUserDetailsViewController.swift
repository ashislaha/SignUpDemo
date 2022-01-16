//
//  ConfirmationWithUserDetailsViewController.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 15/01/22.
//

import UIKit

class ConfirmationWithUserDetailsViewController: UIViewController {
	
	public var user: User? {
		didSet {
			
			guard let user = user else { return }
			
			title = "Hello, \(user.identity.firstName ?? "")"
			name.text = (user.identity.firstName ?? "") + (user.identity.lastName ?? "")
			emailId.text = user.identity.email
			website.text = user.identity.website
			imageView.image = UIImage(data: user.avatarImageData)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		viewSetup()
	}
	
	// MARK: Private APIs and properties
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 8
		return imageView
	}()
	
	private let name: UILabel = {
		let label = UILabel()
		label.contentMode = .center
		label.font = UIFont.preferredFont(forTextStyle: .body)
		return label
	}()
	
	private let emailId: UILabel = {
		let label = UILabel()
		label.contentMode = .center
		label.font = UIFont.preferredFont(forTextStyle: .body)
		return label
	}()
	
	private let website: UILabel = {
		let label = UILabel()
		label.contentMode = .center
		label.font = UIFont.preferredFont(forTextStyle: .body)
		return label
	}()
	
	private let signInButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .orange
		button.setTitle("SignIn", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
		button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
		button.layer.cornerRadius = 8
		return button
	}()
	
	@objc private func signInTapped() {
		print("Sign in is tapped")
	}
	
	private func viewSetup() {
		[imageView, name, emailId, website, signInButton].forEach { view.addSubview($0) }
		
		imageView.anchors(top: view.topAnchor,
						  bottom: name.topAnchor,
						  centerX: view.centerXAnchor,
						  padding: .init(top: 16, left: 0, bottom: 16, right: 0),
						  size: .init(width: 150.0, height: 150.0))
		
		name.anchors(leading: view.leadingAnchor,
					 bottom: emailId.topAnchor,
					 trailing: view.trailingAnchor,
					 padding: .init(top: 0, left: 16, bottom: 8, right: 16))
		
		emailId.anchors(leading: view.leadingAnchor,
						bottom: website.topAnchor,
						trailing: view.trailingAnchor,
						padding: .init(top: 0, left: 16, bottom: 8, right: 16))
		
		website.anchors(leading: view.leadingAnchor,
						trailing: view.trailingAnchor,
						padding: .init(top: 0, left: 16, bottom: 0, right: 16))
		
		signInButton.anchors(leading: view.leadingAnchor,
							 bottom: view.bottomAnchor,
							 trailing: view.trailingAnchor,
							 padding: .init(top: 0, left: 16, bottom: 8, right: 16),
							 size: .init(width: 0, height: 44))
	}
	
}
