//
//  ViewController.swift
//  Project
//
//  Created by Mac on 08/05/2023.
//

import UIKit

class ViewController: UIViewController {
   

    var item = Item()
    var coreData:CoreData = CoreData.shared
    var fromScreen :String=""
    var ref:DeleteProtocol!

    @IBOutlet weak var weeksLB: UILabel!
    @IBOutlet weak var grossLB: UILabel!
    @IBOutlet weak var weekendLB: UILabel!
    @IBOutlet weak var rankLB: UILabel!
    @IBOutlet weak var DetailsImg: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var addFavImag: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tab = UITapGestureRecognizer(target: self, action: #selector(addToFav(_:)))
        addFavImag.addGestureRecognizer(tab)
        
      
          
            titleLB.text =  item.title
            rankLB.text = item.rank
            weekendLB.text = item.weekend
            grossLB.text = item.gross
            weeksLB.text = item.weeks
            let imgUrl = URL(string: item.image ?? "1.png")
            DetailsImg.kf.setImage(with: imgUrl)
            
            if(fromScreen == "Home"){
                deleteBtn.isHidden = false
                
            }else{
                deleteBtn.isHidden = true
                let imageData = Data(base64Encoded: item.image! ) ?? Data()
                DetailsImg.image = UIImage(data: imageData)
                addFavImag.image = UIImage(named: "filled.png")
            }
            
            
            if  coreData.isItemExist(item: item) {
                addFavImag.image = UIImage(named: "filled.png")
                
            } else {
                addFavImag.image = UIImage(named: "outline.png")
            }
            
        
    
    }
   
    
    @objc func addToFav(_ sender:UITapGestureRecognizer) {

        if  coreData.isItemExist(item: item) {
            
            addFavImag.image = UIImage(named: "outline.png")
            coreData.deleteItem(item: item)

        }else{
            //save image as data
            let imageData = DetailsImg.image?.pngData()?.base64EncodedString() ?? "1.png"
            item.image = imageData
            
            addFavImag.image = UIImage(named: "filled.png")
            
            coreData.insertFavItem(itemInserted: item)
        }
        
        
    }
    
    @IBAction func deleteFromFav(_ sender: Any) {
      
        print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
        if(fromScreen == "Home"){
        
            ref?.deleteCellItem(item: item)
          //  coreData.deleteItem(item: item)
            self.navigationController?.popViewController(animated: true)
         
        }else{
            
            coreData.deleteFavItem(item: item)
        }
            
        
    }
    

}


