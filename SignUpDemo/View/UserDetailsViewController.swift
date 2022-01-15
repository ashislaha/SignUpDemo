//
//  UserDetailsViewController.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 15/01/22.
//

import UIKit

class UserDetailsViewController: UIViewController {
	
	public var user: User? {
		didSet {
			
			if let user = user {
				title = "Hello, \(user.identity.firstName)"
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .green
	}
}
