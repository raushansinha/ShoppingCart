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
    var itemTypes: [ItemType] = []
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        itemStore.delegate = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        stores = [Store]()
        //loadStoreTempData()
        //loadItemTypeData()
        getStoreData()
        getItemTypeData()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let image = Image(context: context)
        image.image = thumbImage.image
        
        if(itemToEdit == nil) {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toimage = image
        
        if let title = itemTitle.text {
            item.title = title
        }
        
        if let price = itemPrice.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = itemDetails.text {
            item.details = details
        }
        
        if let title = itemTitle.text {
            item.title = title
        }
        
        item.toStore = stores[itemStore.selectedRow(inComponent: 0)]
        item.toItemType = itemTypes[itemStore.selectedRow(inComponent: 1)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
   
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var thumbImage: UIImageView!
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        
    }
}

extension ItemDetailsVC: UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            return stores.count
        } else {
            return itemTypes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            let currentStore = stores[row]
            return  currentStore.name
        } else {
            let currentItemType = itemTypes[row]
            return currentItemType.type
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Update when selected
        
        //selectedStore.text = stores[row].name
        
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
    
    
    func loadItemTypeData() {
        
        let itype = ItemType(context: context)
        itype.type = "Electronics"
        
        let itype1 = ItemType(context: context)
        itype1.type = "Vehicals"
        
        let itype2 = ItemType(context: context)
        itype2.type = "Musical Intruments"
        
        let itype3 = ItemType(context: context)
        itype3.type = "Appliances"
        
        let itype4 = ItemType(context: context)
        itype4.type = "Books"
        
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
    
    func getItemTypeData() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do{
            
            self.itemTypes =  try context.fetch(fetchRequest)
            self.itemStore.reloadAllComponents()
            
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }

    
    
    func loadItemData() {
     
        if let item = itemToEdit {
            
            itemTitle.text  = item.title;
            itemPrice.text = "\(item.price)"
            itemDetails.text = item.details
            thumbImage.image = item.toimage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if(s.name == store.name) {
                        itemStore.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    
                    index += 1
                    
                } while(index < stores.count)
            }
            
            if let iType = item.toItemType {
                
                var index = 0
                repeat {
                    
                    let t = itemTypes[index]
                    if(t.type == iType.type) {
                        itemStore.selectRow(index, inComponent: 1, animated: false)
                        break
                    }
                    
                    index += 1
                    
                } while(index < itemTypes.count)
            }
        }
    }
}
