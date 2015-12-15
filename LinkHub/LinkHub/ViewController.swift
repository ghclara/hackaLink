//
//  ViewController.swift
//  LinkHub
//
//  Created by Student on 14/12/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var CollectionPastas: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.CollectionPastas.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let pastas = ["a", "b", "c"]
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pastas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = CollectionPastas.dequeueReusableCellWithReuseIdentifier("collectionCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "mostrarTelaListagem" {
            if let viewController2 = segue.destinationViewController as? ListagemViewController{
                let texto = sender?.textLabel!.text
                ListagemViewController.pasta = texto
            }
        }
    }
    
    
}

