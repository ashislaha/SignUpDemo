//
//  UIView+Extension.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 14/01/22.
//

import UIKit

extension UIView {
	
	/// fill the current to its super view.
	/// - Parameters:
	///   - edgeInset: pass the inset value, default is .zero
	func fillSuperView(edgeInset: UIEdgeInsets = .zero) {
		
		guard let viewSuperView = self.superview else { return }
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			leadingAnchor.constraint(equalTo: viewSuperView.leadingAnchor, constant: edgeInset.left),
			bottomAnchor.constraint(equalTo: viewSuperView.bottomAnchor, constant: -edgeInset.bottom),
			trailingAnchor.constraint(equalTo: viewSuperView.trailingAnchor, constant: -edgeInset.right),
			topAnchor.constraint(equalTo: viewSuperView.topAnchor, constant: edgeInset.top)
		])
	}
	
	/// set the specified anchors for the receiver.
	/// - Parameters:
	///   - top: layout anchor that the top of the receiver is constrained to.
	///   - leading: layout anchor that the left of the receiver is constrained to.
	///   - bottom: layout anchor that the bottom of the receiver is constrained to.
	///   - trailing: layout anchor that the right of the receiver is constrained to.
	///   - centerX: layout anchor that the horizontal center of the receiver is constrained to.
	///   - centerXConstants: constant for the centerX anchor.
	///   - centerY: layout anchor that the vertical center of the receiver is constrained to.
	///   - centerYConstants: constant for the centerY anchor.
	///   - padding: the edge inset value.
	///   - size: size that the receiver should be constrained to.
	func anchors(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil,
				 bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,
				 centerX: NSLayoutXAxisAnchor? = nil, centerXConstants: CGFloat = 0.0,
				 centerY: NSLayoutYAxisAnchor? = nil, centerYConstants: CGFloat = 0.0,
				 padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
		
		// enable auto-layout for that view
		translatesAutoresizingMaskIntoConstraints = false
		
		var constraints: [NSLayoutConstraint] = []
		if let top = top {
			constraints.append(topAnchor.constraint(equalTo: top, constant: padding.top))
		}
		if let leading = leading {
			constraints.append(leadingAnchor.constraint(equalTo: leading, constant: padding.left))
		}
		if let bottom = bottom {
			constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom))
		}
		if let trailing = trailing {
			constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -padding.right))
		}
		if size.height > 0 {
			constraints.append(heightAnchor.constraint(equalToConstant: size.height))
		}
		if size.width > 0 {
			constraints.append(widthAnchor.constraint(equalToConstant: size.width))
		}
		if let centerX = centerX {
			constraints.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConstants))
		}
		if let centerY = centerY {
			constraints.append(centerYAnchor.constraint(equalTo: centerY, constant: centerYConstants))
		}
		
		NSLayoutConstraint.activate(constraints)
	}
}
