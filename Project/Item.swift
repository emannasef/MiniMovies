//
//  Item.swift
//  Project
//
//  Created by Mac on 08/05/2023.
//

import Foundation
class Item : Decodable,Equatable{
    
    
    
    
    
    var id : String?
    var rank : String?
    var title : String?
    var image : String?
    var weekend : String?
    var gross : String?
    var weeks : String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case rank = "rank"
        case title = "title"
        case image = "image"
        case weekend = "weekend"
        case gross = "gross"
        case weeks = "weeks"
    }
    
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.rank == rhs.rank && lhs.title == rhs.title && lhs.image == rhs.image && lhs.weekend == rhs.weekend && lhs.gross == rhs.gross && lhs.weeks == rhs.weeks
    }
}
