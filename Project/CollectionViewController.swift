//
//  CollectionViewController.swift
//  Project
//
//  Created by Mac on 08/05/2023.
//

import UIKit
import Kingfisher
import Reachability

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,DeleteProtocol {

    
   
    
    let indicator=UIActivityIndicatorView(style: .large)
    var myRes:[Item] = []
    var reachability:Reachability?
    var coreData:CoreData = CoreData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        
        indicator.startAnimating()
        
        
        do{
            reachability = try Reachability()
            try reachability?.startNotifier()
        }
        catch{
            print("cant creat object of rechability")
            print("Unable to start notifier")
        }
      
        rech()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width/2-20 , height:  100 )
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myRes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        var cellItem:Item = myRes[indexPath.row]
        
        cell.titleLB.text = cellItem.title ?? "No Title"
        
        let imgUrl = URL(string: cellItem.image ?? "1.png")
        
        cell.movieImg.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "1.png"))
        
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "showDetails") as! ViewController
        
        detailsViewController.item = myRes[indexPath.row]
        detailsViewController.fromScreen = "Home"
        detailsViewController.ref = self
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    
    func deleteCellItem(item: Item) {
       // myRes.remove(at: index)
       // let item : Item = myRes[index]
        
        self.coreData.deleteItem(item: item)
        
        if let myIndex = myRes.firstIndex(of: item) {
            myRes.remove(at: myIndex)
        }
       // myRes = self.coreData.getStoredFavItems()
        collectionView.reloadData()
    }
    
    
    
    func rech (){
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                
                loadData { [weak self] (result) in
                    DispatchQueue.main.async {
                      
                        self?.myRes = result?.items ?? []
                        
                       self?.coreData.getStoredItems()
                        
                        self?.coreData.deleteAll()
                        
                        for i in self?.myRes ?? []{
                            
                            self?.coreData.insertItem(itemInserted: i )
                            
                        }
                        
                        self?.collectionView.reloadData()
                        self?.indicator.stopAnimating()
                    }
                }
                
                
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            self.myRes = self.coreData.getStoredItems()
            print("COUNT######################################",self.myRes.count)
            self.collectionView.reloadData()
            self.indicator.stopAnimating()
        }
    }
}
