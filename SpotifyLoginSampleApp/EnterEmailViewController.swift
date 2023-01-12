//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Jamong on 2023/01/12.
//

import UIKit

class EnterEmailViewController: UIViewController {
	@IBOutlet weak var emailTextFiled: UITextField!
	@IBOutlet weak var passwordTextFiled: UITextField!
	@IBOutlet weak var errorMessageLabel: UILabel!
	@IBOutlet var nextButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nextButton.layer.cornerRadius = 30
		
		nextButton.isEnabled = false
		
		emailTextFiled.delegate = self
		passwordTextFiled.delegate = self
		
		emailTextFiled.becomeFirstResponder()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	
		// Navigation Bar Hidden
		navigationController?.navigationBar.isHidden = false
		
	}
	
	@IBAction func nextButtonTapped(_ sender: UIButton) {
		
	}
}


extension EnterEmailViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		return false
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		let isEmailEmpty = emailTextFiled.text == ""
		let passwordEmpty = passwordTextFiled.text == ""
		nextButton.isEnabled = !isEmailEmpty && !passwordEmpty
	}
}
