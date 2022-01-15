//
//  FieldView.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import UIKit

protocol FieldViewDelegate: AnyObject {
	
	func fieldViewDidBeginInteracting(_ view: FieldView, type: FieldType)
	
	func fieldViewDidEndInteracting(_ view: FieldView, type: FieldType, value: String)
	
	func fieldViewValidationError(_ view: FieldView, type: FieldType)
}

class FieldView: UIView {
	
	weak var delegate: FieldViewDelegate?
	
	var fieldType: FieldType = .none {
		didSet {
			textField.placeholder = fieldType.placeHolderText
			textField.isSecureTextEntry = fieldType == .password
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		viewSetup()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented.")
	}
	
	// MARK: Private APIs
	
	private let textField: UITextField = {
		let textField = UITextField()
		textField.textAlignment = .center
		return textField
	}()
	
	private let errorLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		label.textColor = .red
		label.isHidden = true
		return label
	}()
	
	private func viewSetup() {
		textField.delegate = self
		
		[textField, errorLabel].forEach { addSubview($0) }
		textField.anchors(top: topAnchor,
						  leading: leadingAnchor,
						  bottom: errorLabel.topAnchor,
						  trailing: trailingAnchor,
						  padding: .init(top: 0, left: 0, bottom: 4, right: 0),
						  size: .init(width: 0, height: 56))
		
		errorLabel.anchors(leading: leadingAnchor,
						   bottom: bottomAnchor,
						   trailing: trailingAnchor,
						   size: .init(width: 0, height: 22))
		
		textField.layer.cornerRadius = 5
		textField.layer.borderColor = UIColor.gray.cgColor
		textField.layer.borderWidth = 0.5
	}

	private let fieldValidation = FieldValidation()
}

extension FieldView: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		
		
		delegate?.fieldViewDidBeginInteracting(self, type: fieldType)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		guard let text = textField.text, !text.isEmpty else {
			errorLabel.isHidden = false
			errorLabel.text = "Field should not be empty"
			return
		}
		
		let isValid = fieldValidation.validateField(type: fieldType, inputText: text)
		errorLabel.isHidden = isValid.0
		
		if isValid.0 {
			delegate?.fieldViewDidEndInteracting(self, type: fieldType, value: text)
		} else {
			errorLabel.text = isValid.1
			delegate?.fieldViewValidationError(self, type: fieldType)
		}
	}
}
