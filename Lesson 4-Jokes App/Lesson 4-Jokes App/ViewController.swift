//
//  ViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 3/4/21.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doStuff()
    }
    
    func doStuff(){
        let db = FirebaseFirestore.Firestore.firestore()
        
        db.collection("test").document("woo").setData(["HIII" : 1])
    }

}

