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
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
        self.CollectionPastas.dataSource = self

        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            print("Erro ao buscar pastas: \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK:- Retrieve Tasks
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: pastaFetchRequest(), managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func pastaFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Pasta")
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        print("linhas:", numberOfSections)
        
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mostrarTelaListagem" {
            let cell = sender as! UICollectionViewCell
            let indexPath = CollectionPastas.indexPathForCell(cell)
            let listagemController: ListagemViewController = segue.destinationViewController as! ListagemViewController
            let pasta: Pasta = fetchedResultController.objectAtIndexPath(indexPath!) as! Pasta
            listagemController.pasta = pasta
        }
        
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        CollectionPastas.reloadData()
    }
    
}

