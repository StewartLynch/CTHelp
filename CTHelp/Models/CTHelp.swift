//
//  Help.swift
//  CreaTECH Help
//
//  Created by Stewart Lynch on 11/24/17.
//  Copyright © 2017 CreaTECH Solutiions. All rights reserved.
//

import UIKit

/// A Class for creating and presenting an array of HelpItems in a modal ViewController that has a transparent background.

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
///    ctHelp.new(CTHelpItem(title:"No Text-Image Only",
///                          helpText: "",
///                          imageName:"SampleFullSizeImage"))
///    ctHelp.new(CTHelpItem(title:"Text and Image",
///                          helpText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
///                          imageName:"SampleSmallerImage"))
///    ctHelp.new(CTHelpItem(title:"No Image-Text Only",
///                          helpText: "Eu tempor suscipit dis sed. Tortor velit orci bibendum mattis non metus ornare consequat. Condimentum habitasse dictumst eros nibh rhoncus non pulvinar fermentum. Maecenas convallis gravida facilisis. Interdum, conubia lacinia magnis duis nec quisque.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
///                          imageName:""))
///  // Optional addition of two default cards
///    ctHelp.appendDefaults(companyName: "CreaTECH Solutions", emailAddress: "books@createchsol.com", data: nil, webSite: "https://www.createchsol.com/CreaTechApps", companyImageName: "CreaTECH")
///
///    ctHelp.presentHelp(from: self)
///}
///
/// ```
///

public class CTHelp {
public  var helpItems:[CTHelpItem] = []
public var ctMailtintColor:UIColor?

public init(){}
     /// Create a new help item and add it to the helpItems Array.
     ///
     /// - Parameter helpItem: an item of help.
    public func new(_ ctHelpItem:CTHelpItem) {
        helpItems.append(ctHelpItem)
    }
    
    /// Add defaults to the end of the helpItems array.
   public func appendDefaults(companyName:String, emailAddress:String?, data:Data?, webSite:String?, companyImageName:String?) {
        
        let developerWebSite = CTHelpItem(title:"\(companyName)",
                                        helpText: "\(Bundle.main.displayName) is created by \(companyName).  Please visit our website for more information about our company.",
            imageName:companyImageName ?? "",
            btn:.Web,
            webSite: webSite)
        let appContact = CTHelpItem(title: "Contact Developer",
                                    helpText: "\(companyName) would very much like to assist you if you are having issues with \(Bundle.main.displayName). Please tap button below to initiate an email to the developer." + (data != nil ? "  If you agree, your data will be compiled and sent to the developer for analysis." : ""),
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
        ctHelpVC.ctHelpItem = helpItems
        ctHelpVC.mailTintColor = ctMailtintColor
        
        vc.present(ctHelpVC,animated: true)
    }
}
