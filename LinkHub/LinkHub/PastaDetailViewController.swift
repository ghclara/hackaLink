//
//  PastaDetailViewController.swift
//  LinkHub
//
//  Created by Student on 12/16/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class PastaDetailViewController: UIViewController {
    //contexto contendo as informacoes do banco de dados
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    @IBOutlet weak var PastaLabel: UITextField!
    var pasta: Pasta? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if pasta != nil {
            PastaLabel.text = pasta?.nome
        }
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewController()
    }
    @IBAction func done(sender: AnyObject) {
        if pasta != nil {
            editPasta()
        } else {
            createPasta()
        }
        dismissViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK:- Dismiss ViewControllers
    
    func dismissViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:- Create task
    
    func createPasta() {
        let entityDescription = NSEntityDescription.entityForName("Pasta", inManagedObjectContext: contexto)
        let pasta = Pasta(entity: entityDescription!, insertIntoManagedObjectContext: contexto)
        pasta.nome = PastaLabel.text
        do {
            try contexto.save()
        } catch let error as NSError {
            print("Erro ao editar pasta")
            print(error)
        }
    }
    
    // MARK:- Edit task
    
    func editPasta() {
        pasta?.nome = PastaLabel.text
        do {
            try contexto.save()
        } catch _ {
            print("Erro ao editar pasta")
        }
        
    }

}
