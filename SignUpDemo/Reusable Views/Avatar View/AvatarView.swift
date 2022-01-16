//
//  AvatarView.swift
//  SignUpDemo
//
//  Created by Ashis Laha on 15/01/22.
//

import UIKit

protocol AvatarViewDelegate: AnyObject {
	
	/// delegate once a new avatar is picked.
	func avatarPicked(_ view: AvatarView, image: UIImage)
	
	/// need the parent controller to present ImagePicker
	func parentController() -> UIViewController
}

class AvatarView: UIView, UINavigationControllerDelegate {
	
	weak var delegate: AvatarViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		viewSetup()
	}
	
	required init?(coder: NSCoder) {
		preconditionFailure("init(coder:) has not been implemented.")
	}
	
	// MARK: Private APIs
	
	private let imagePickerController = UIImagePickerController()
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .lightGray
		imageView.layer.cornerRadius = 10
		return imageView
	}()
	
	private let label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		label.textColor = .white
		label.font = UIFont.boldSystemFont(ofSize: 18)
		label.textAlignment = .center
		label.text = "Tap to add avatar"
		return label
	}()
	
	private func viewSetup() {
		addSubview(imageView)
		imageView.anchors(bottom: bottomAnchor,
						  centerX: centerXAnchor,
						  centerY: centerYAnchor,
						  size: .init(width: 150, height: 150))
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
		addGestureRecognizer(tapGesture)
		
		imageView.addSubview(label)
		label.anchors(top: imageView.topAnchor,
					  leading: imageView.leadingAnchor,
					  bottom: imageView.bottomAnchor,
					  trailing: imageView.trailingAnchor,
					  padding: .init(top: 0, left: 16, bottom: 0, right: 16))
	}
	
	@objc private func pickImage() {
		
		imagePickerController.delegate = self
		
		let alertController = UIAlertController(title: "Choose your avatar", message: "Source", preferredStyle: .alert)
		
		let galleryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
			self.imagePickerController.sourceType = .photoLibrary
			self.delegate?.parentController().present(self.imagePickerController, animated: true, completion: nil)
		}
		
		let cameraAction = UIAlertAction(title: "Camera", style: .default) {  alertAction in
			self.imagePickerController.sourceType = .camera
			self.delegate?.parentController().present(self.imagePickerController, animated: true, completion: nil)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		[galleryAction, cameraAction, cancelAction].forEach { alertController.addAction($0) }
		delegate?.parentController().present(alertController, animated: true, completion: nil)
	}
	
}

// MARK: UIImagePickerControllerDelegate

extension AvatarView: UIImagePickerControllerDelegate {
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		imagePickerController.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
		guard let image = image else { return }
		
		delegate?.avatarPicked(self, image: image)
		imageView.image = image
		imagePickerController.dismiss(animated: true, completion: nil)
		label.isHidden = true
	}
}
