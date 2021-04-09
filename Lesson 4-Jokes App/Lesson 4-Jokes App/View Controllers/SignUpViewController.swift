//
//  SignUpViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 8/4/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if(username.text == "" || email.text == "" || password.text == ""){
            let alert = UIAlertController(title: "Error", message: "One of the fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
            print("Unable to sign user up due to empty field")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email.text as! String, password: password.text as! String, completion: {[weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Account creation failed")
                let alert = UIAlertController(title: "Error", message: "Account Creaation Failed, possibly due to incorrect password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .cancel, handler: { _ in
                print("Unable to sign user up due to empty field")
                }))
                strongSelf.present(alert, animated: true, completion: nil)
                return
            }
            
            print("Sign in sucessful")
            
            //update firebase
            let db = FirebaseFirestore.Firestore.firestore()
            db.collection("User").document(FirebaseAuth.Auth.auth().currentUser?.uid as! String).setData([
                "username": strongSelf.username.text as! String,
                "email": strongSelf.email.text as! String,
                "uid": FirebaseAuth.Auth.auth().currentUser!.uid,
            ])
            print("woo")
        })

        self.dismiss(animated: true, completion: nil)
    }
    
}
