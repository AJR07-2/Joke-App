//
//  Post.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 6/4/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Post: UITableViewCell {
    var id: String
    
    //details on post
    @IBOutlet var Number: UILabel!
    @IBOutlet var Username: UILabel!
    @IBOutlet var ProfilePic: UIImageView!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    //rating
    @IBOutlet var upvote: UIButton!
    @IBOutlet var downvote: UIButton!
    @IBOutlet weak var votes: UILabel!
    
    //joke itself
    @IBOutlet var Joke: UILabel!
    @IBOutlet weak var jokeImage: UIImageView!
    @IBOutlet weak var revealPunchLine: UIButton!
    @IBOutlet weak var punchLine: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkVoted()
        if (FirebaseAuth.Auth.auth().currentUser == nil){
            favouriteButton.isHidden = true
            upvote.isHidden = true
            downvote.isHidden = true
            votes.isHidden = true
        }else{
            favouriteButton.isHidden = false
            upvote.isHidden = false
            downvote.isHidden = false
            votes.isHidden = false
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //button press reactions
    @IBAction func favourite(_ sender: Any) {
        
    }
    
    @IBAction func upvoteClicked(_ sender: Any) {
        
    }

    @IBAction func downvoteClicked(_ sender: Any) {
        
    }
    
    @IBAction func RevealPunchLine(_ sender: Any) {
        revealPunchLine.isHidden = true
        punchLine.isHidden = false
        punchLine.alpha = 0
        UIView.animate(withDuration: 3) {
            self.punchLine.alpha = 1
        }
    }
    
    func vote(){
        
    }
    
    func checkVoted(){
        FirebaseFirestore.Firestore.firestore().collection("Posts").document(id).collection("RatingHistory").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID == FirebaseAuth.Auth.auth().currentUser?.uid){
                        if(document.data()["Contributions"] as! Int == 1){
                            upvote.alpha = 1
                        }else{
                            downvote.alpha = 1
                        }
                        break
                    }
                }
            }
            upvote.alpha = 0.5
            downvote.alpha = 0.5
        }
    }
}
