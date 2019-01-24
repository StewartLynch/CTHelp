//
//  StorageFunctions.swift
//  My Books
//
//  Created by Stewart Lynch on 2019-01-17.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//

import Foundation

class StorageFunctions {
    
    static func retrieveBooks() -> [BookItem] {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if let bookData = defaults.string(forKey: "BookData") {
            guard let savedItems = try? decoder.decode([BookItem].self, from: bookData.data(using: .ascii)!) else {
                fatalError("Can't Decode data")
            }
            return savedItems
        
        } else {
            guard let url = Bundle.main.url(forResource: "Books", withExtension: "json") else {
                fatalError("Can't find Sample Data")}
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Unable to load sample data")
            }
            guard let sampleItems = try? decoder.decode([BookItem].self, from: data) else {
                fatalError("Failed to decode JSON from SampleData")
            }
            return sampleItems
        }
    }
    
    static func encodedBooks(books:[BookItem]) -> String {
        let encoder = JSONEncoder()
        guard let bookJSONData = try? encoder.encode(books) else {
            fatalError("Failed to encode data")
        }
        return String(data: bookJSONData, encoding: .utf8)!
    }
    
    static func storeBooks(books:[BookItem]) {
        let defaults = UserDefaults.standard
        let bookJSON = encodedBooks(books: books)
        defaults.set(bookJSON, forKey: "BookData")
    }
}
