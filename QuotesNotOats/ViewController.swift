//
//  ViewController.swift
//  QuotesNotOats
//
//  Created by Dino Srdoč on 17/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

import UIKit

struct Quote: Codable, CustomStringConvertible {
    let quoteAuthor: String
    let quoteText: String
    
    var description: String {
        return """
            --- \(quoteAuthor) ---
            \(quoteText)
            """
    }
}

class QuoteFetcher {
    let session = URLSession.shared
    static let urlPath = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"
    static let url = URL(string: urlPath)
    
    static func fetch(_ completion: @escaping (Quote?) -> Void) {
        guard let url = url else {
            print("badurl")
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let quote = try? JSONDecoder().decode(Quote.self, from: data)
                completion(quote)
            }
        }
        
        task.resume()
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showQuoteInUI()
    }
    
    @IBAction func getQuote(_ sender: UIButton) {
        showQuoteInUI()
    }
    
    func showQuoteInUI() {
//        DispatchQueue.global(qos: .userInteractive).async {
            QuoteFetcher.fetch { quote in
                if let quote = quote {
                    DispatchQueue.main.async {
                        self.authorLabel.text = quote.quoteAuthor.isEmpty ? "Anonymous" : quote.quoteAuthor
                        self.quoteLabel.text = quote.quoteText
                    }
                }
            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

