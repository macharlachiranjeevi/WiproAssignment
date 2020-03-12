//
//  AboutCanadaModel.swift
//  WiproAssignment
//
//  Created by chiranjeevi macharla on 12/03/20.
//  Copyright © 2020 chiranjeevi macharla. All rights reserved.
//

import UIKit
// Model to map data from API response
struct Product {
    var productName : String?
    var productImage : String?
    var productDesc : String?
}

// Model to map data from API response
struct ProductList {
    var productTittle : String?
    var productlist : [Product]
    init?(with tittle:String,_ list:[Product]) {
        self.productTittle = tittle
        self.productlist = list
    }
}
