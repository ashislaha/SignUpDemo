//
//  FieldView.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import UIKit

protocol FieldViewDelegate: AnyObject {
	
	func fieldViewDidBeginInteracting(_ view: FieldView)
	
	func fieldViewDidEndInteracting(_ view: FieldView)
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
						   trailing: trailingAnchor)
		
		textField.layer.cornerRadius = 5
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.layer.borderWidth = 0.5
	}
	
	/// Validate each field type whether the input text satisfies all the constraints.
	/// - Parameters:
	///   - type: what type of field it is.
	///   - inputText: input text associated with type.
	private func validateField(type: FieldType, inputText: String) -> (Bool, String?) {

		// we are using a regualar expression to validate a field.
		// https://rubular.com/r/UAwoaPM0Ji helps to understand the RegEx.
		
		return (false, nil)
	}
}

extension FieldView: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return true
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		
		
		delegate?.fieldViewDidBeginInteracting(self)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		// TODO: validate field first, show error if needed otherwise delegate if field value is good. Reset errorLabel if needed.
		delegate?.fieldViewDidEndInteracting(self)
	}
}
