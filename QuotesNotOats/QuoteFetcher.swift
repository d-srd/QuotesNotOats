//
//  QuoteFetcher.swift
//  QuotesNotOats
//
//  Created by Dino Srdoč on 19/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

import Foundation

class QuoteFetcher {
    let session = URLSession.shared
    static let urlPath = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"
    static let url = URL(string: urlPath)
    
    static func fetch(_ completion: @escaping (Quote?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            if let data = data {
                let quote = try? JSONDecoder().decode(Quote.self, from: data)
                completion(quote)
                return
            }
        }
        
        task.resume()
    }
}
