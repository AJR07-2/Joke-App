//
//  PostViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 6/4/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PostViewController: UIViewController {

    @IBOutlet weak var TextField: UITextView!
    
    @IBOutlet weak var punchLineSubmissionField: UITextView!
    
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //making the UI look nicer
        TextField.backgroundColor = .gray
        TextField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 0)
        TextField.layer.borderWidth = 5
        TextField.layer.cornerRadius = 5
        TextField.layer.masksToBounds = true

        
        punchLineSubmissionField.backgroundColor = .gray
        punchLineSubmissionField.layer.borderColor = CGColor(red: 0, green: 255, blue: 0, alpha: 0)
        punchLineSubmissionField.layer.borderWidth = 5
        punchLineSubmissionField.layer.cornerRadius = 5
        punchLineSubmissionField.layer.masksToBounds = true
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPost(_ sender: Any) {
        let db = FirebaseFirestore.Firestore.firestore()
        let user = FirebaseAuth.Auth.auth().currentUser?.uid as! String
        var username:String = ""
        FirebaseFirestore.Firestore.firestore().collection("User").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.data()["uid"] as! String == FirebaseAuth.Auth.auth().currentUser?.uid as! String){
                        username = document.data()["username"] as! String
                    }
                }
                
                if(TextField.text == "" || punchLineSubmissionField.text == ""){
                    warning.isHidden = false
                    return
                }
                db.collection("Posts").addDocument(data:
                [
                    "Joke": TextField.text!,
                    "PunchLine": punchLineSubmissionField.text!,
                    "UserID": user,
                    "User": username,
                    "Likes" : 0,
                    "Dislikes": 0,
                    "DateCreated": Date(),
                    "Comments": 0
                ]
                )
                warning.isHidden = true
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
