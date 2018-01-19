//
//  Quote.swift
//  QuotesNotOats
//
//  Created by Dino Srdoč on 19/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

import Foundation

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
