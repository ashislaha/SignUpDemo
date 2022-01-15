//
//  SignUpTableViewCell.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import UIKit

protocol SignUpTableViewCellDelegate: AnyObject {
	
	func fieldViewDidBeginInteracting(_ cell: SignUpTableViewCell, type: FieldType)
	
	func fieldViewDidEndInteracting(_ cell: SignUpTableViewCell, type: FieldType, value: String)
	
	func fieldViewValidationError(_ cell: SignUpTableViewCell, type: FieldType)
}

class SignUpTableViewCell: UITableViewCell {
	
	weak var delegate: SignUpTableViewCellDelegate?
	
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
	
	func fieldViewDidBeginInteracting(_ view: FieldView, type: FieldType) {
		delegate?.fieldViewDidBeginInteracting(self, type: type)
	}
	
	func fieldViewDidEndInteracting(_ view: FieldView, type: FieldType, value: String) {
		delegate?.fieldViewDidEndInteracting(self, type: type, value: value)
	}
	
	func fieldViewValidationError(_ view: FieldView, type: FieldType) {
		delegate?.fieldViewValidationError(self, type: type)
	}
}
