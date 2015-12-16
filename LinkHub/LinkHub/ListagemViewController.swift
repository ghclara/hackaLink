//
//  ListagemViewController.swift
//  LinkHub
//
//  Created by Student on 12/15/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class ListagemViewController: UIViewController, UITableViewDataSource , NSFetchedResultsControllerDelegate {

    @IBOutlet weak var listaLinks: UITableView!
    
    var pasta: Pasta? = nil

    @IBOutlet weak var nomePasta: UILabel!
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        

        do{
            try fetchedResultController.performFetch()
        } catch let error as NSError{
            print("Erro ao buscar tarefas: \(error), \(error.userInfo)")
        }
        self.nomePasta.text = pasta?.nome
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: linkFetchRequest(), managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func linkFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Link")
        let sortDescription = NSSortDescriptor(key: "url", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        return fetchRequest
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellLink", forIndexPath: indexPath)
//        let link = fetchedResultController.objectAtIndexPath(indexPath) as! Link
        cell.textLabel?.text = "Teste"
        return cell
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
