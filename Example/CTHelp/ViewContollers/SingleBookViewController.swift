//
//  SingleBookViewController.swift
//  CTHelp_Example
//
//  Created by Stewart Lynch on 2019-01-23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import CTHelp

class SingleBookViewController: UIViewController {
    
    var book:BookItem!
    weak var delegate:ViewController?
    
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var notes: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Notification to know when to scroll the notes textview when keyboard covers text being entered
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        notes.layer.cornerRadius = 14.0
        notes.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        bookTitle.text = book.title
        author.text = book.author
        notes.text = book.notes
        
        // Dismiss keyboard when tapped outsied of notes textview
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        book.notes = notes.text ?? ""
        delegate?.updateBook(book: book)
    }
    
    @IBAction func loadCTHelp(_ sender: Any) {
        showCTHelp()
    }
    
    // Adjusts the notes textview when the keyboard is visible
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            notes.contentInset = UIEdgeInsets.zero
        } else {
            notes.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        notes.scrollIndicatorInsets = notes.contentInset
        
        let selectedRange = notes.selectedRange
        notes.scrollRangeToVisible(selectedRange)
    }
}

extension SingleBookViewController {
    // Extended just to keep the help separate
    func showCTHelp() {
        let ctHelp = CTHelp()
        ctHelp.new(CTHelpItem(title:"My Books",
                              helpText: "",
                              imageName:"MyBooksLogo"))
        ctHelp.new(CTHelpItem(title:"Update Note",
                              helpText: "Just type in the notes field to update your note.\nThe note will be saved when you tap the back arrow,",
                              imageName:"UpdateNote"))
        
        // Only add the email help item to the end and no data is included.
        ctHelp.appendDefaults(companyName: "CreaTECH Solutions", emailAddress: "slynch@createchsol.com", data: nil, webSite: nil, companyImageName: nil)
        ctHelp.presentHelp(from: self)
    }
}
