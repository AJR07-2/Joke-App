//
//  Post.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 6/4/21.
//

import UIKit

class Post: UITableViewCell {

    @IBOutlet var Number: UILabel!
    @IBOutlet var Username: UILabel!
    @IBOutlet var ProfilePic: UIImageView!
    @IBOutlet var upvote: UIButton!
    @IBOutlet var downvote: UIButton!
    @IBOutlet var favourite: UIButton!
    @IBOutlet var Joke: UILabel!
    @IBOutlet weak var Time: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
