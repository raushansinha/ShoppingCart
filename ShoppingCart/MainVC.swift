//
//  MainVC.swift
//  ShoppingCart
//
//  Created by Raushan Sinha on 6/24/17.
//  Copyright © 2017 Raushan Sinha. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
 
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    var fetchedResultController : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       // fetchedResultController.delegate = self
        
//        let nib = UINib(nibName: "ItemViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "ItemViewCell")
        //generateTestData()
        attemptFetch()
        
        tableView.register(ItemViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        
        attemptFetch()
        tableView.reloadData()
    }
    
}


extension MainVC: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = fetchedResultController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ItemViewCell
            configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemViewCell, indexPath: NSIndexPath) {
        //update cell
        let item = fetchedResultController.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination  as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = fetchedResultController.fetchedObjects, objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort: NSSortDescriptor = NSSortDescriptor(key: "created", ascending: false)
        let priceSort: NSSortDescriptor = NSSortDescriptor(key: "price", ascending: true)
        let titleSort: NSSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let typeSort: NSSortDescriptor = NSSortDescriptor(key: "toItemType", ascending: true)
        
        if(sortSegment.selectedSegmentIndex == 0) {
           fetchRequest.sortDescriptors = [dateSort]
        } else if  sortSegment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        } else if sortSegment.selectedSegmentIndex == 2{
            fetchRequest.sortDescriptors = [titleSort]
        } else {
            fetchRequest.sortDescriptors = [typeSort]
        }
        
        
        
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.fetchedResultController = controller
        
        do{
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func generateTestData() {
        let item = Item(context: context)
        
        item.title = "New MacBook Pro"
        item.price = 1800
        item.details = "New MacBook pro 15\" CPU:core i7 HHD:500GB RAM:8GB"
        
        let item2 = Item(context: context)

        item2.title = "New iPhone 7s Plus"
        item2.price = 1000
        item2.details = "New iPhone 7s plus Unlocked with 256 GH storage"

        let item3 = Item(context: context)
        item3.title = "STIGA Table Tennis Racket"
        item3.price = 50
        item3.details = "Performance-Level Table Tennis Racket ITTF Approved Rubber for Tournament Play"
        
        ad.saveContext()
    }
    
}

