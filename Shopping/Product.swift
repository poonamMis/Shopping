//
//  Product.swift
//  Shopping
//
//  Created by king on 4/24/18.
//  Copyright © 2018 king. All rights reserved.
//

import UIKit
import Foundation

struct Product {
    var productName: String
    var ProductPrice: String
    var productImage: String?
    
    init?(name:String, price:String, image:String){

        guard !name.isEmpty else{
            return nil
        }

//        guard price>0 else {
//            return nil
//        }

        self.productName = name
        self.ProductPrice = price
        self.productImage = image
    }
}

extension Product: Decodable{
    
    enum myStructKeys: String, CodingKey {
        case productName = "productname"
        case ProductPrice = "price"
        case productImage = "productImg"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: myStructKeys.self)
        let pname:String = try container.decode(String.self, forKey: .productName)
        let price: String = try container.decode(String.self, forKey: .ProductPrice)
        let url: String = try container.decode(String.self, forKey: .productImage)
        
        
        //        public init(decoder: JSONDecoder) throws {
        //            self.productName = try decoder.decode(key: "productname")
        //            self.ProductPrice = try decoder.decode(key: "price")
        //            self.productImage = try decoder.decode(key: "productImg")
        //        }
        
        self.init(name: pname, price: price, image: url)!
    }
}

extension Product: Encodable{
    enum myKeys: String, CodingKey {
        case productName = "productname"
        case ProductPrice = "price"
        case productImage = "productImg"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: myKeys.self)
        try container.encode(productName, forKey: .productName)
        try container.encode(ProductPrice, forKey: .ProductPrice)
        try container.encode(productImage, forKey: .productImage)

    }
}
