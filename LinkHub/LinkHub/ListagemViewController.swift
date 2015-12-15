//
//  ListagemViewController.swift
//  LinkHub
//
//  Created by Student on 12/15/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit

class ListagemViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    var pasta: String?
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            try fetchedResultController.performFetch()
        } catch let error as NSError{
            print("Erro ao buscar tarefas: \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
