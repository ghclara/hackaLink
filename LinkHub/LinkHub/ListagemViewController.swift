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

    @IBOutlet weak var mLabel: UINavigationItem!
    @IBOutlet weak var listaLinks: UITableView!
    
    var pasta: Pasta? = nil

    @IBOutlet weak var nomePasta: UILabel!
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listaLinks.dataSource = self
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        

        do{
            try fetchedResultController.performFetch()
        } catch let error as NSError{
            print("Erro ao buscar tarefas: \(error), \(error.userInfo)")
        }
        self.mLabel.title = pasta?.nome
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: linkFetchRequest(), managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func linkFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Link")
        let sortDescription = NSSortDescriptor(key: "url", ascending: true)
        let filter = pasta
        let predicate = NSPredicate(format: "pasta = %@", filter!)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescription]
        return fetchRequest
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellLink", forIndexPath: indexPath)
        let link = fetchedResultController.objectAtIndexPath(indexPath) as! Link
        cell.textLabel?.text = link.url
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let manageObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        contexto.deleteObject(manageObject)
        do {
            try contexto.save()
        } catch _ {
            print("Erro ao deletar link")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mostrarTelaLink" {
            let listagemController: LinkDetailViewController = segue.destinationViewController as! LinkDetailViewController
            listagemController.pasta = pasta
        }
        
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        listaLinks.reloadData()
    }
}
