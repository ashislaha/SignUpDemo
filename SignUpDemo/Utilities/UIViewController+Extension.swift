//
//  UIViewController+Extension.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 15/01/22.
//

import UIKit

extension UIViewController {

	/// showAlert: this method is used to show an alert view with default "Ok" button. At least title or message should be non-nil.
	/// - Parameters:
	///   - title: pass the title of the alert. it should be localised string.
	///   - message: pass the message information of the alert. it should be localised.
	///   - buttonTitle: pass the button title. (e.g. Okay)
	///   - buttonHandler: Instance of a block/closure which will execute on tap of the button.
	@objc public func showAlert(
		title: String? = nil,
		message: String? = nil,
		buttonTitle: String? = nil,
		buttonHandler: ((UIAlertAction) -> Void)? = nil
	) {
		guard title != nil || message != nil else {
			return
		}

		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: buttonTitle, style: .default, handler: buttonHandler)
		alertController.addAction(action)
		present(alertController, animated: true, completion: nil)
	}
	
}
