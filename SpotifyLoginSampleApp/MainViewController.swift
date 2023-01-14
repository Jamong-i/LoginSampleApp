//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Jamong on 2023/01/12.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
	@IBOutlet weak var welcomeLabel: UILabel!
	@IBOutlet var resetPasswordButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.interactivePopGestureRecognizer?.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.navigationBar.isHidden = true
		
		let email = Auth.auth().currentUser?.email ?? "고객"
		
		welcomeLabel.text = """
		환영합니다.
		\(email)님
		"""
		
		let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
		resetPasswordButton.isHidden = !isEmailSignIn
	}
	
	@IBAction func logoutButtonTapped(_ sender: UIButton) {
		let firebaseAuth = Auth.auth()
		// 로그아웃
		do {
			try firebaseAuth.signOut()
			self.navigationController?.popToRootViewController(animated: true)
		} catch let signOutError as NSError {
			print("Error: signOut \(signOutError.localizedDescription)")
		}
	}
	@IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
		let email = Auth.auth().currentUser?.email ?? ""
		Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
	}
}

