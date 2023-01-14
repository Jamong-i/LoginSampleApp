//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Jamong on 2023/01/12.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
	@IBOutlet var emailLoginButton: UIButton!
	@IBOutlet var googleLoginButton: GIDSignInButton!
	@IBOutlet var appleLoginButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		[emailLoginButton, googleLoginButton, appleLoginButton].forEach {
			$0?.layer.borderWidth = 1
			$0?.layer.borderColor = UIColor.white.cgColor
			$0?.layer.cornerRadius = 30
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		
		// Navigation Bar Hidden
		navigationController?.navigationBar.isHidden = true
		
		// Google Sign In
		GIDSignIn.sharedInstance.presentingViewController = self
	}
	
	// Firebase 인증
	@IBAction func googleLoginButtonTapped(_ sender: UIButton) {
		guard let clientID = FirebaseApp.app()?.options.clientID else { return }
		let config = GIDConfiguration(clientID: clientID)
		GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
		  if let error = error {
			  print("ERROR", error.localizedDescription)
			return
		  }

		  guard let authentication = user?.authentication,
				let idToken = authentication.idToken else { return }

		  let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

			Auth.auth().signIn(with: credential) { _, _ in
				self.showMainViewController()
			}
		}
	}

	
	// Firebase 인증
	@IBAction func appleLoginButtonTapped(_ sender: UIButton) {
	}
	
}
