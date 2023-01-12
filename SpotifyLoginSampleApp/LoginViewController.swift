//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by Jamong on 2023/01/12.
//

import UIKit

class LoginViewController: UIViewController {
	@IBOutlet var emailLoginButton: UIButton!
	@IBOutlet var googleLoginButton: UIButton!
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
	}
	
	// Firebase 인증
	@IBAction func googleLoginButtonTapped(_ sender: UIButton) {
	}
	
	// Firebase 인증
	@IBAction func appleLoginButtonTapped(_ sender: UIButton) {
	}
	
}
