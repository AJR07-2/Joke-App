//
//  PostViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 6/4/21.
//

import UIKit
import FirebaseFirestore

class PostViewController: UIViewController {

    @IBOutlet weak var TextField: UITextView!
    
    @IBOutlet weak var SubmissionField: UIStackView!
    
    @IBOutlet weak var warning: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextField.backgroundColor = .gray
        TextField.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 0)
        TextField.layer.borderWidth = 10
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPost(_ sender: Any) {
        let db = FirebaseFirestore.Firestore.firestore()
        
        if(TextField.text == ""){
            warning.isHidden = false
            return
        }
        
        db.collection("Posts").addDocument(data:
        [
            "Joke": TextField.text!,
            "User": "NIL",
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
