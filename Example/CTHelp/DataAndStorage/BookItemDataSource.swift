//
//  MemoryDataSource.swift
//  My Books
//
//  Created by Stewart Lynch on 2019-01-11.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//

import UIKit

class BookItemDataSource: NSObject, UITableViewDataSource {
    
    var books = [BookItem]()
    let defaults = UserDefaults.standard
    
    override init() {
        books = StorageFunctions.retrieveBooks()
    }
    
    func addBook(with title:String, author:String) {
        let book = BookItem(title:title, author:author, notes: "")
        books.append(book)
        StorageFunctions.storeBooks(books: books)
    }
    
    func saveBooks() {
        StorageFunctions.storeBooks(books: books)
    }
    
    func deleteBook(at index:Int) {
        books.remove(at: index)
        StorageFunctions.storeBooks(books: books)
    }
    
    func book(at index:Int) -> BookItem {
        return books[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        return cell
    }
    
    
}
