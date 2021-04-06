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
    
    var jokes:[[String: Any]] = []
    
    var timer:Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        
        //load table view data
        let nib =  UINib(nibName: "Post", bundle: nil)
        postJokes.register(nib, forCellReuseIdentifier: "Post")
        postJokes.delegate = self
        postJokes.dataSource = self
        
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [self] (_) in
            fetchPosts()
        })
        fetchPosts()
    }
    
    @IBAction func Sync(_ sender: Any) {
        fetchPosts()
    }
    
    @IBAction func AddPost(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let postViewController = storyboard.instantiateViewController(withIdentifier: "Post") as? PostViewController{
            self.present(postViewController, animated: true, completion: nil)
        }else{
            print("Something went wrong :(")
        }
        
    }
    
    func fetchPosts(){
        let database = FirebaseFirestore.Firestore.firestore()
        
        database.collection("Posts").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                jokes = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    jokes.append(data)
                }
            }
            postJokes.reloadData()
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
        
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postJokes.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! Post
        let data = jokes[indexPath[1]]
        cell.Username.text = "None"
        cell.Number.text = "\(indexPath[1] + 1)"
        cell.Joke.text = "\(data["Joke"] as! String)"
        
        
        //time conversion
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"

        
        let date:Timestamp = data["DateCreated"] as! Timestamp
        let convertedDate : Date = date.dateValue()
        let reConvertedDate = dateFormatter.string(from: convertedDate)
        
        cell.Time.text = "\(reConvertedDate)"
        
        return cell
    }
    
}
