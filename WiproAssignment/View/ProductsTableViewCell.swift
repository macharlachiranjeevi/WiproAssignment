//
//  ProductsTableViewCell.swift
//  WiproAssignment
//
//  Created by chiranjeevi macharla on 12/03/20.
//  Copyright © 2020 chiranjeevi macharla. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
