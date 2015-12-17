//
//  TableViewCell.swift
//  LinkHub
//
//  Created by Student on 12/17/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var btnIr: UIButton!
    
    @IBAction func btnAbrirLink(sender: AnyObject) {
        let urlString = NSURL(string: linkLabel.text!)
        //NSWorkspace.sharedWorkspace().openURL(urlString)
        UIApplication.sharedApplication().openURL(urlString!)
    }
    
    @IBOutlet weak var linkLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
