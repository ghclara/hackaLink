//
//  LinkDetailViewController.swift
//  LinkHub
//
//  Created by Student on 12/16/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class LinkDetailViewController: UIViewController {
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var linkTextField: UITextField!
    var link: Link? = nil
    var pasta: Pasta? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if link != nil {
            linkTextField.text = link?.url
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewController()
    }
    @IBAction func done(sender: AnyObject) {
        if link != nil {
            editLink()
        } else {
            createLink()
        }
        dismissViewController()
    }
    func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK:- Create task
    
    func createLink() {
        let entityDescription = NSEntityDescription.entityForName("Link", inManagedObjectContext: contexto)
        let link = Link(entity: entityDescription!, insertIntoManagedObjectContext: contexto)
        link.url = linkTextField.text
        link.pasta = pasta
        do {
            try contexto.save()
        } catch let error as NSError {
            print("Erro ao editar link")
            print(error)
        }
    }
    
    // MARK:- Edit task
    
    func editLink() {
        link?.url = linkTextField.text
        do {
            try contexto.save()
        } catch _ {
            print("Erro ao editar pasta")
        }
        
    }

}
