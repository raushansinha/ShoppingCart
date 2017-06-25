//
//  ItemDetailsVC.swift
//  ShoppingCart
//
//  Created by Raushan Sinha on 6/25/17.
//  Copyright © 2017 Raushan Sinha. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController {

    @IBOutlet weak var itemTitle: CustomTextField!
    @IBOutlet weak var itemPrice: CustomTextField!
    @IBOutlet weak var itemDetails: CustomTextField!
    @IBOutlet weak var itemStore: UIPickerView!
    @IBOutlet weak var selectedStore: UILabel!
    
    
    var stores: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        itemStore.delegate = self
        
        stores = [Store]()
        //loadStoreTempData()
        getStoreData()
    }
    

extension ItemDetailsVC: UIPickerViewDataSource, UIPickerViewDelegate   {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let currentStore = stores[row]
        return  currentStore.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Update when selected
        
        selectedStore.text = stores[row].name
        
    }
    
    func loadStoreTempData() {
        
        let store = Store(context: context)
        store.name = "Walmart"
        
        let store1 = Store(context: context)
        store1.name = "Best Buy"
        
        let store2 = Store(context: context)
        store2.name = "Target"
        
        let store3 = Store(context: context)
        store3.name = "K Mart"
        
        let store4 = Store(context: context)
        store4.name = "Amazon"
        
        let store5 = Store(context: context)
        store5.name = "Home Depot"
        
        ad.saveContext()
    }
    
    func getStoreData() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            
            self.stores =  try context.fetch(fetchRequest)
            self.itemStore.reloadAllComponents()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
}
