//
//  CanadaViewModel.swift
//  WiproAssignment
//
//  Created by chiranjeevi macharla on 12/03/20.
//  Copyright © 2020 chiranjeevi macharla. All rights reserved.
//

import UIKit

class CanadaViewModel: NSObject {
 var datalist = [Product]()
    override init() {
      }
    func fetchDataFromApi(successBlock: @escaping (ProductList,String ) ->Void,failureBlock: @escaping (String ) ->Void) {
        APIHandler.networkmanager.callWebServiceGet(urlString: StaticString.baseUrl, parameter: nil, successBlock: { (canadaresponse) in
            var productList:ProductList?
             guard let tittle = canadaresponse["title"] as? String else {
                        return
                    }
            guard let canadaArray = canadaresponse["rows"] as? [[String: Any]] else {
                       return
                   }
            self.datalist = []
            for values in canadaArray{
                self.datalist.append(Product(title:values["title"] as? String ?? "No value", description: values["description"] as? String ?? "No value", imageHref: values["imageHref"] as? String ?? "No value"))
            }
            if(self.datalist.count > 0){
            productList = ProductList(with: tittle, self.datalist)
            successBlock(productList!,tittle)
            }
            else{
                failureBlock(StaticString.somethingWentWrong)
            }
        }) { (ErrorString) in
            failureBlock(ErrorString)
        }
}
}
