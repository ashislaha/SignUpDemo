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
		
		tableView.separatorStyle = .none
		tableView.register(SignUpTableViewCell.self, forCellReuseIdentifier: "cell")
		
		tableView.estimatedRowHeight = 100
		tableView.rowHeight = UITableView.automaticDimension
		
		tableView.estimatedSectionHeaderHeight = 200
		tableView.sectionHeaderHeight = UITableView.automaticDimension
	}
	
	// MARK: Private APIs and properties
	
	private let viewModel = SignupViewModel()
	
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
		cell.fieldType = viewModel.fields[indexPath.row]
		return cell
	}
}
