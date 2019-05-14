//
//  ViewController.swift
//  My Books
//
//  Created by Stewart Lynch on 1/16/19.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//

import UIKit
import CTHelp

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let dataSource = BookItemDataSource()
    var selectedBook:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        setupNavBar()
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SingleBookViewControllerSegue" {
            let vc = segue.destination as! SingleBookViewController
            let row = tableView.indexPathForSelectedRow?.row
            let book = dataSource.book(at: row!)
            selectedBook = row!
            vc.title = book.title
            vc.book = book
            vc.delegate = self
        }
    }
    
    func setupNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBook))
        let ctHelpButton = UIBarButtonItem(image: UIImage(named: "CTHelp"), style: .plain, target: self, action: #selector(showCTHelp))

        navigationItem.rightBarButtonItems = [ctHelpButton,addButton]
    }
    
    func updateBook(book:BookItem) {
        guard let selectedBook = selectedBook else {return}
        dataSource.books[selectedBook] = book
        dataSource.saveBooks()
    }
    
    @objc func addBook() {
        let alert = UIAlertController(title: "New Book", message: "Add your new book", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Book Title"
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Author"
            textField.autocapitalizationType = .words
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let title = alert.textFields![0] as UITextField
            let author = alert.textFields![1] as UITextField
            guard title.text != "", author.text != "" else {return}
            self.dataSource.addBook(with: title.text!, author: author.text!)
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        alert.view.tintColor = UIColor.bookAppTint
        present(alert,animated: true)
    }
    
    @objc func showCTHelp() {
        let ctHelp = CTHelp()
        ctHelp.ctMailtintColor = UIColor.bookAppTint

        
        ctHelp.new(CTHelpItem(title:"List of books",
                              helpText: "This screen shows a list of all of the books that you have read.\nAs you read more books you read more books you can add to this list.\nYou can also remove books from the list as well.  See the other help screens here for more information.",
                              imageName:""))
        ctHelp.new(CTHelpItem(title:"Adding a Book",
                              helpText: "To add a book to your collection, tap on the '+' button on the navigation bar.\nEnter the book title and author and tap the 'Add' button",
                              imageName:"AddBook"))
        ctHelp.new(CTHelpItem(title:"Removing a Book",
                              helpText: "To remove a book from your list, swipe from the right to the left and choose 'Remove Book'.",
                              imageName:"RemoveBook"))
        
        // This gathers data from the application and encodes it as a JSON String
        let books = StorageFunctions.retrieveBooks()
        let encodedBooks = StorageFunctions.encodedBooks(books: books)
        let data = encodedBooks.data(using: .utf8)
        
        ctHelp.appendDefaults(companyName: "CreaTECH Solutions", emailAddress: "books@createchsol.com", data: data, webSite: "https://www.createchsol.com/CreaTechApps", companyImageName: "CreaTECH")
        ctHelp.presentHelp(from: self)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SingleBookViewControllerSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Remove Book") { (action, view, actionPerformed: (Bool) -> ()) in
            self.dataSource.deleteBook(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            actionPerformed(true)
        }
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
