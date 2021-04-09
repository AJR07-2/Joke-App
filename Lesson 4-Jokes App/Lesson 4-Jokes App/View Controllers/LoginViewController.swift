//
//  LoginViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 8/4/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signIn(_ sender: Any) {
        //TODO: implement sign in
        self.dismiss(animated: true, completion: nil)
    }
}
