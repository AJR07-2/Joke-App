//
//  APIViewController.swift
//  Lesson 4-Jokes App
//
//  Created by Ang Jun Ray on 14/4/21.
//

import UIKit

class APIViewController: UIViewController {

    @IBOutlet weak var joke: UILabel!
    @IBOutlet weak var revealPunchline: UIButton!
    @IBOutlet weak var punchline: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joke.layer.cornerRadius = 5
        joke.layer.masksToBounds = true
        
        punchline.layer.cornerRadius = 5
        punchline.layer.masksToBounds = true
        
        generateJoke()
    }
    
    @IBAction func goHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favourite(_ sender: Any) {
        
    }
    
    @IBAction func revealPunchline(_ sender: Any) {
        revealPunchline.isHidden = true
        punchline.isHidden = false
        punchline.alpha = 0
        
        UIView.animate(withDuration: 3) { [self] in
            punchline.alpha = 1
        }
    }
    
    @IBAction func nextJoke(_ sender: Any) {
        joke.text = "Loading..."
        punchline.text = "Loading..."
        generateJoke()
    }
    
    func generateJoke(){
        let url = URL(string: "https://icanhazdadjoke.com/")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [self] data, response, error2 in
            
            guard let data = data, error2 == nil else{
                print("Something went wrong")
                return
            }
            
            //converting data
            var result: Response?
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("failed to convert")
                print(data)
                print(error)
            }
            
            if let json = result{
                
                print(json.joke.components(separatedBy: ".").count, json.joke.components(separatedBy: "."))
                
//                let joke = json.joke.components(separatedBy: ".")[0]
//
//                let punchline = json.joke.components(separatedBy: ".")[1]
                
                //updateData(joke: joke, punchline: punchline)
                
                print("Joke parsed sucessfully")
            } else{
                print("could not parse joke")
                return
            }
        })
        
        task.resume()
    }
    
    func updateData(joke jokeParsed: String, punchline punchlineParsed: String){
        joke.text = jokeParsed
        punchline.text = punchlineParsed
    }
}

struct Response: Codable{
    let status: Int
    let joke: String
    let id: String
}


