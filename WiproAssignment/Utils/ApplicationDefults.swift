//
//  ApplicationDefults.swift
//  WiproAssignment
//
//  Created by chiranjeevi macharla on 12/03/20.
//  Copyright © 2020 chiranjeevi macharla. All rights reserved.
//

import UIKit

func presentAlert(_ target : UIViewController, title: String?, buttonTitle:String?, message : String?, closure: @escaping (_ action: UIAlertAction) -> Void )
{
    
    let alrtCntr = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okayAction = UIAlertAction(title: buttonTitle, style: .default, handler: closure)
    alrtCntr.addAction(okayAction)
    DispatchQueue.main.async {
        target.present(alrtCntr, animated: true, completion: nil)
}
    
}


func imageFunction (image:UIImage,sizeValues:CGSize) -> UIImage{
    
    UIGraphicsBeginImageContext (sizeValues)
    image.draw(in: CGRect(x: 0,y: 0,width: sizeValues.width,height: sizeValues.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return (newImage?.withRenderingMode(.alwaysOriginal))!
}
