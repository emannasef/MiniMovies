//
//  CoreData.swift
//  Project
//
//  Created by Mac on 09/05/2023.
//

import Foundation

import UIKit
import CoreData


class CoreData {
    
    var manager : NSManagedObjectContext!
    var itemsArr : [NSManagedObject] = []
    var movieToBeDeleted : NSManagedObject?
    
    static let shared = CoreData()
    
    private init(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    
    
    
    func insertItem(itemInserted: Item){
        
        //2-
        let entity = NSEntityDescription.entity(forEntityName: "MyItem", in: manager)
        //3-
        let item1 = NSManagedObject(entity: entity!, insertInto: manager)
        
        
        item1.setValue(itemInserted.title, forKey: "title")
        item1.setValue(itemInserted.id, forKey: "id")
        item1.setValue(itemInserted.gross, forKey: "gross")
        item1.setValue(itemInserted.image, forKey: "image")
        item1.setValue(itemInserted.weekend, forKey:"weekend")
        item1.setValue(itemInserted.weeks, forKey: "weeks")
        
        //4-
        do{
            try manager.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func deleteItem(item : Item){
        for i in itemsArr{
            
            if ((i.value(forKey: "title") as! String) == item.title){
                
                movieToBeDeleted = i
            }
        }
        
        guard let item1 = movieToBeDeleted else{
            print("cannot be deleted!")
            return
        }
        manager.delete(item1)
        do{
            try manager.save()
            print("Deleted!")
            movieToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    func getStoredItems() -> [Item]{
        
        var items = [Item]()
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "MyItem")
        
        do{
            itemsArr = try manager.fetch(fetch)
            if(itemsArr.count > 0){
                movieToBeDeleted = itemsArr.first
            }
            
            for i in itemsArr{
                var  myItem = Item()
                
                myItem.title = i.value(forKey: "title") as? String
                myItem.id = i.value(forKey: "id") as? String
                myItem.gross = i.value(forKey:"gross" ) as? String
                myItem.image = i.value(forKey: "image") as? String
                myItem.weekend =  i.value(forKey: "weekend") as? String
                myItem.weeks =  i.value(forKey: "weeks") as? String
                
                items.append(myItem)
            }
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        return items
        
    }
    
    
    func deleteAll(){
    //    itemsArr = res
        print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
        for i in itemsArr{
            
            movieToBeDeleted = i
            
            guard let item1 = movieToBeDeleted else{
                print("cannot be deleted!")
                return
            }
            manager.delete(item1)
        }
        
        do{
            try manager.save()
            print("Deleted!")
            movieToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
            print("not deleted!!")
        }
    }
    
    
    
    
    func insertFavItem(itemInserted: Item){
        
        //2-
        let entity = NSEntityDescription.entity(forEntityName: "FavItem", in: manager)
        //3-
        let item1 = NSManagedObject(entity: entity!, insertInto: manager)
        
        item1.setValue(itemInserted.title, forKey: "title")
        item1.setValue(itemInserted.id, forKey: "id")
        item1.setValue(itemInserted.gross, forKey: "gross")
        item1.setValue(itemInserted.image, forKey: "image")
        item1.setValue(itemInserted.weekend, forKey:"weekend")
        item1.setValue(itemInserted.weeks, forKey: "weeks")
        item1.setValue(itemInserted.rank, forKey: "rank")
        
        //4-
        do{
            try manager.save()
            print("Fav Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func getStoredFavItems() -> [Item]{
        
        var items = [Item]()
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavItem")
        
        do{
            itemsArr = try manager.fetch(fetch)
            if(itemsArr.count > 0){
                movieToBeDeleted = itemsArr.first
            }
            
            for i in itemsArr{
                var myItem = Item()
                
                myItem.title = i.value(forKey: "title") as? String
                myItem.id = i.value(forKey: "id") as? String
                myItem.gross = i.value(forKey:"gross" ) as? String
                myItem.image = i.value(forKey: "image") as? String
                myItem.weekend =  i.value(forKey: "weekend") as? String
                myItem.weeks =  i.value(forKey: "weeks") as? String
                items.append(myItem)
            }
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        return items
        
    }
    
    
    
    
    func deleteFavItem(item : Item){
        
        for i in itemsArr{
            if ((i.value(forKey: "title") as! String) == item.title){
                
                movieToBeDeleted = i
            }
        }
        
        guard let movie1 = movieToBeDeleted else{
            print("cannot be deleted!")
            return
        }
        manager.delete(movie1)
        do{
            try manager.save()
            print("Fav Deleted!")
            movieToBeDeleted = nil
        }catch let error{
            print(error.localizedDescription)
            print("Fav not deleted!!")
        }
    }
    
    
    func isItemExist(item : Item) -> Bool{
        
        let items = [Item]()
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavItem")
        
        // predicate
        let predicate = NSPredicate(format: "title == %@", item.title!)
        
        fetch.predicate = predicate
        do{
            itemsArr = try manager.fetch(fetch)
            if(itemsArr.count > 0){
                print("Fav is exist")
                return true
            }else{
                return false
            }
            
            
        }catch let error{
            print(error.localizedDescription)
        }
        
        return false
    }
    
}




