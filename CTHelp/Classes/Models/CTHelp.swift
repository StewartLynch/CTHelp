//
//  Help.swift
//  CTHelp
//
//  Created by Stewart Lynch on 11/24/17.
//  Copyright © 2017 CreaTECH Solutiions. All rights reserved.
//

import UIKit

/// A Class for creating and presenting an array of HelpItems in a modal ViewController that has a transparent background.
/// - Parameter helpItem: an item of help.
///
/// For Example:
///
/// On each viewController that you wish to present a help screen, simply create a function that will be pesented by the action associated with your help button.
/// This function adds in your help items for the particlar screen.

///
/// ```
///
///func showCTHelp() {

///    let ctHelp = CTHelp()
///    // Optional values to set colors
///    // ctHelp.ctBgViewColor = .white
///    // ctHelp.ctTitleColor = .darkText
///    // ctHelp.ctHelpTextColor = .darkGray
///    // ctHelp.ctActionButtonBGColor = UIColor(red: 28/255, green: 136/255, blue: 197.255, alpha: 1)
///    // ctHelp.ctActionButtonTextColor = .white
///    // ctHelp.ctContactString = "Contact Developer"
///    // ctHelp.ctWebString = "Visit Web Site"
///
///    ctHelp.new(CTHelpItem(title:"No Text-Image Only",
///                          helpText: "",
///                          imageName:"SomeFullSizedImage"))
///    ctHelp.new(CTHelpItem(title:"Text and Image",
///                          helpText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
///                          imageName:"SomeSmallImage"))
///    ctHelp.new(CTHelpItem(title:"No Image-Text Only",
///                          helpText: "Eu tempor suscipit dis sed. Tortor velit orci bibendum mattis non metus ornare consequat. Condimentum habitasse dictumst eros nibh rhoncus non pulvinar fermentum. Maecenas convallis gravida facilisis. Interdum, conubia lacinia magnis duis nec quisque.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
///                          imageName:""))
///
///  // Optional addition of two default cards
///    ctHelp.appendDefaults(companyName: "Your Company Name", emailAddress: "yourContactEmail@somewhere.com", data: nil, webSite: "https://www.yourWebsite.com", companyImageName: "CompanyLogo")
///
///    ctHelp.presentHelp(from: self)
///}
///
/// ```
///

public class CTHelp {
    
    public  var helpItems:[CTHelpItem] = []
    
    public var ctMailtintColor:UIColor?
    public var ctBgViewColor:UIColor?
    public var ctHelpTextColor:UIColor?
    public var ctTitleColor:UIColor?
    public var ctActionButtonBGColor:UIColor?
    public var ctActionButtonTextColor:UIColor?
    
    // Custom Strings
    public var ctWebButtonTitle:String?
    public var ctContactButtonTitle:String?
    public var ctWebHelpText:String?
    public var ctContactTitle:String?
    public var ctContactHelpText:String?
    public var ctIncludeDataText:String?
    public var ctDataAlertTitle:String?
    public var ctDataAlertMessage:String?
    public var ctDataAlertActionNo:String?
    public var ctDataAlertActionYes:String?
    public var ctEmailSubject:String?
    public var ctEmailPreface:String?
    public var ctEmailBody:String?
    public var ctEmailAttachNote:String?
    
    public init(){}
    /// Create a new help item and add it to the helpItems Array.
    ///
    /// - Parameter helpItem: an item of help.
    public func new(_ ctHelpItem:CTHelpItem) {
        helpItems.append(ctHelpItem)
    }
    
    /// Add defaults to the end of the helpItems array.
    public func appendDefaults(companyName:String, emailAddress:String?, data:Data?, webSite:String?, companyImageName:String?) {
        let contactBody1 = ctContactHelpText ?? "\(companyName) would very much like to assist you if you are having issues with \(Bundle.main.displayName). Please tap button below to initiate an email to the developer."
        let contactBody2 = ctIncludeDataText ?? "  If you agree, your data will be compiled and sent to the developer for analysis."
        
        let developerWebSite = CTHelpItem(title:"\(companyName)",
            helpText: ctWebHelpText ?? "\(Bundle.main.displayName) is created by \(companyName).  Please visit our website for more information about our company.",
            imageName:companyImageName ?? "",
            btn:.Web,
            webSite: webSite)
        let appContact = CTHelpItem(title: ctContactTitle ?? "Contact Developer",
                                    helpText: contactBody1 + (data != nil ? contactBody2 : ""),
                                    imageName: "",
                                    btn:.Email,
                                    contactEmail:emailAddress,
                                    data:data)
        if let _ = webSite {
            helpItems.append(developerWebSite)
        }
        if let _ = emailAddress {
            helpItems.append(appContact)
        }
        
    }
    
    /// Present the help in a modal screen: Always use 'self' as the viewController.
    public func presentHelp(from vc:UIViewController) {
        let ctHelpVC = CTHelpViewController.loadTransparentModal(fromStoryboardNamed: "CTHelp") as! CTHelpViewController
        let ctString = CTString(contactButtonTitle: self.ctContactButtonTitle,
                                webButtonTitle: self.ctWebButtonTitle,
                                webHelpText: self.ctWebHelpText,
                                contactTitle: self.ctContactTitle,
                                contactHelpText: self.ctContactHelpText,
                                includeDataText: self.ctIncludeDataText,
                                dataAlertTitle: self.ctDataAlertTitle,
                                dataAlertMessage: self.ctDataAlertMessage,
                                dataAlertActionNo: self.ctDataAlertActionNo,
                                dataAlertActionYes: self.ctDataAlertActionYes,
                                emailSubject: self.ctEmailSubject,
                                emailPreface: self.ctEmailPreface,
                                emailBody: self.ctEmailBody,
                                emailAttachNote: self.ctEmailSubject)
        ctHelpVC.ctString = ctString
        ctHelpVC.ctHelpItem = helpItems
        ctHelpVC.mailTintColor = ctMailtintColor
        ctHelpVC.bgViewColor = ctBgViewColor
        ctHelpVC.helpTextColor = ctHelpTextColor
        ctHelpVC.titleColor = ctTitleColor
        ctHelpVC.actionButtonBGColor = ctActionButtonBGColor
        ctHelpVC.actionButtonTextColor = ctActionButtonTextColor
        vc.present(ctHelpVC,animated: true)
    }
}
