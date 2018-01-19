//
//  ViewController.swift
//  QuotesNotOats
//
//  Created by Dino Srdoč on 17/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

import UIKit

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
        DispatchQueue.global(qos: .userInteractive).async {
            QuoteFetcher.fetch { quote in
                if let quote = quote {
                    DispatchQueue.main.async {
                        self.authorLabel.text = quote.quoteAuthor.isEmpty ? "Anonymous" : quote.quoteAuthor
                        self.quoteLabel.text = quote.quoteText
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.authorLabel.text = "Coudln't fetch a quote"
                        self.quoteLabel.text = "The two most powerful warriors are patience and time."
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

