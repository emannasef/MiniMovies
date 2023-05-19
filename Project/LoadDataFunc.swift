//
//  LoadDataFunc.swift
//  Project
//
//  Created by Mac on 08/05/2023.
//

import Foundation
func loadData(compilitionHandler: @escaping (Root?) -> Void){
    //1-
   // let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_b18gz207")
    
    let url = URL(string: "https://imdb-api.com/en/API/BoxOffice/k_g2vhvf72")
    
    guard let urlFinal = url else {
        return
    }
    //2-
    let request = URLRequest(url: urlFinal)
    //3-
    let session = URLSession(configuration: .default)
    //4-
    let task = session.dataTask(with: request) { (data, response, error) in
        //6-
        guard let data = data else{
            return
        }
        do{

            let result = try JSONDecoder().decode(Root.self, from: data)
       //     print(result.items[0].title ?? "No title")
            compilitionHandler(result)
            
        }catch let error{
            print(error.localizedDescription)
            compilitionHandler(nil)
        }
    }
    //5-
    task.resume()
    
}
