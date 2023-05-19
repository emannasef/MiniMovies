//
//  FavViewController.swift
//  Project
//
//  Created by Mac on 09/05/2023.
//

import UIKit
import Kingfisher

class FavViewController: UIViewController{
    

    @IBOutlet weak var tableView: UITableView!
    var favArr:[Item] = []
    var item : Item?
    var coreData:CoreData = CoreData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        item = Item()
    
        favArr=[]
        
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favArr = coreData.getStoredFavItems()
        tableView.reloadData()
    }


}


extension FavViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        
        cell.textLabel?.text = favArr[indexPath.row].title
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        let imageData = Data(base64Encoded: favArr[indexPath.row].image! ) ?? Data()
        
        cell.imageView?.image = UIImage(data: imageData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "showDetails") as! ViewController
        
        detailsViewController.item = favArr[indexPath.row]
        detailsViewController.fromScreen = "fav"
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            showAlert(index: indexPath.row)
            
        }
    }
    
    func deleteMovie(index : Int){
        let item : Item = favArr[index]
        
        self.coreData.deleteFavItem(item: item)
        
        favArr = self.coreData.getStoredFavItems()
        tableView.reloadData()
    }
    
 
    func showAlert(index : Int){
        
        let alert : UIAlertController = UIAlertController(title: "Delete Movie", message: "Are you sure that, Do yo want to delete movie?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
            self.deleteMovie(index: index)
            
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
