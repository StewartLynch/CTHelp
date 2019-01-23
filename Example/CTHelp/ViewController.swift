//
//  ViewController.swift
//  CTHelp
//
//  Created by aurimas@engagecraft.com on 01/23/2019.
//  Copyright (c) 2019 aurimas@engagecraft.com. All rights reserved.
//

import UIKit
import CTHelp

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		let ctHelp = CTHelp()
		ctHelp.new(CTHelpItem(title:"No Text-Image Only",
							  helpText: "",
							  imageName:"SampleFullSizeImage"))
		ctHelp.new(CTHelpItem(title:"Text and Image",
							  helpText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
							  imageName:"SampleSmallerImage"))
		ctHelp.new(CTHelpItem(title:"No Image-Text Only",
							  helpText: "Eu tempor suscipit dis sed. Tortor velit orci bibendum mattis non metus ornare consequat. Condimentum habitasse dictumst eros nibh rhoncus non pulvinar fermentum. Maecenas convallis gravida facilisis. Interdum, conubia lacinia magnis duis nec quisque.Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
							  imageName:""))
		// Optional addition of two default cards
		ctHelp.appendDefaults(companyName: "CreaTECH Solutions", emailAddress: "books@createchsol.com", data: nil, webSite: "https://www.createchsol.com/CreaTechApps", companyImageName: "CreaTECH")
		
		ctHelp.presentHelp(from: self)
		
	}
}

