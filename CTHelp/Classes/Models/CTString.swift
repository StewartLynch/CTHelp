//
//  CTString.swift
//  CTHelp
//
//  Created by Stewart Lynch on 2019-05-13.
//

import Foundation

public class CTString {
    internal init(contactButtonTitle: String?, webButtonTitle: String?, webHelpText: String?, contactTitle: String?, contactHelpText: String?, includeDataText: String?, dataAlertTitle: String?, dataAlertMessage: String?, dataAlertActionNo: String?, dataAlertActionYes: String?, emailSubject: String?, emailPreface: String?, emailBody: String?, emailAttachNote: String?) {
        self.contactButtonTitle = contactButtonTitle
        self.webButtonTitle = webButtonTitle
        self.webHelpText = webHelpText
        self.contactTitle = contactTitle
        self.contactHelpText = contactHelpText
        self.includeDataText = includeDataText
        self.dataAlertTitle = dataAlertTitle
        self.dataAlertMessage = dataAlertMessage
        self.dataAlertActionNo = dataAlertActionNo
        self.dataAlertActionYes = dataAlertActionYes
        self.emailSubject = emailSubject
        self.emailPreface = emailPreface
        self.emailBody = emailBody
        self.emailAttachNote = emailAttachNote
    }

    public  var contactButtonTitle:String?
    public  var webButtonTitle:String?
    public var webHelpText:String?
    public var contactTitle:String?
    public var contactHelpText:String?
    public var includeDataText:String?
    public var dataAlertTitle:String?
    public var dataAlertMessage:String?
    public var dataAlertActionNo:String?
    public var dataAlertActionYes:String?
    public var emailSubject:String?
    public var emailPreface:String?
    public var emailBody:String?
    public var emailAttachNote:String?
    
    
    
}
