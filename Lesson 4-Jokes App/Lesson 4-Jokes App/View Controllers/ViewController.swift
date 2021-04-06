//
//  ViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 3/4/21.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet var postJokes:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postJokes.delegate = self
        postJokes.dataSource = self
    }
    

    @IBAction func AddPost(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let postViewController = storyboard.instantiateViewController(withIdentifier: "Post") as? PostViewController{
            self.present(postViewController, animated: true, completion: nil)
        }else{
            print("Something went wrong :(")
        }
        
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show profile of person later
        print("cell is tapped")
        return
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postJokes.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
}
