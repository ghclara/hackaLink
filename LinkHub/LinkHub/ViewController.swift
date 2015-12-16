//
//  ViewController.swift
//  LinkHub
//
//  Created by Student on 14/12/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()

    @IBOutlet weak var CollectionPastas: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionPastas.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            print("Erro ao buscar pastas: \(error), \(error.userInfo)")
        }
    }
    
    // MARK:- Retrieve Tasks
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: pastaFetchRequest(), managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func pastaFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Tasks")
        let sortDescriptor = NSSortDescriptor(key: "descricao", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = CollectionPastas.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionViewCell
        let pasta = fetchedResultController.objectAtIndexPath(indexPath) as! Pasta
        cell.textLabel?.text = pasta.nome
        return cell
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//        let task = fetchedResultController.objectAtIndexPath(indexPath) as! Tasks
//        cell.textLabel?.text = task.descricao! + " (" + task.local! + ")"
//        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mostrarTelaListagem" {
            if let viewController2 = segue.destinationViewController as? ListagemViewController{
                let texto = sender?.textLabel!!.text
                viewController2.pasta = texto
            }
        }
    }
    
    
}

