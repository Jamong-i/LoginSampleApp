//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Jamong on 2023/01/12.
//

import UIKit
import FirebaseAuth

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
		// Firebase 이메일/비밀번호 인증
		let email = emailTextFiled.text ?? ""
		let password = passwordTextFiled.text ?? ""
		
		// 신규 사용자 생성
		Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
			guard let self = self else { return }
			
			if let error = error {
				let code = (error as NSError).code
				switch code {
				case 17007:	// 이미 가입한 계정일때 로그인하기
					self.loginUser(withEmail: email, password: password)
				default:
					self.errorMessageLabel.text = error.localizedDescription
				}
			} else {
					self.showMainViewController()
			}
		}
	}
	
	private func showMainViewController() {
		let stroyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let mainViewController = stroyboard.instantiateViewController(identifier: "MainViewController")
		mainViewController.modalPresentationStyle = .fullScreen
		navigationController?.show(mainViewController, sender: nil)
	}
	
	private func loginUser(withEmail email: String, password: String) {
		Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
			guard let self = self else { return }
			
			if let error = error {
				self.errorMessageLabel.text = error.localizedDescription
			} else {
				self.showMainViewController()
			}
		}
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
