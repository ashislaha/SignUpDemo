//
//  SignUpTableViewCell.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {
	
	var fieldType: FieldType = .none {
		didSet {
			fieldView.fieldType = fieldType
		}
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		viewSetup()
		selectionStyle = .none
	}
	
	required init?(coder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented.")
	}
	
	private func viewSetup() {
		contentView.addSubview(fieldView)
		fieldView.delegate = self
		fieldView.fillSuperView(edgeInset: .init(top: 8, left: 16, bottom: 8, right: 16))
	}
	
	private let fieldView: FieldView = {
		let view = FieldView()
		return view
	}()
}

extension SignUpTableViewCell: FieldViewDelegate {
	
	func fieldViewDidBeginInteracting(_ view: FieldView) {
		
	}
	func fieldViewDidEndInteracting(_ view: FieldView) {
		
	}
}
