//
//  UIView+extension.swift
//  viper-sample
//
//  Created by hicka04 on 2018/07/27.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import UIKit

extension UIView {
    
    static var className: String {
        return String(describing: self)
    }
    
    static func createNib(bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: className, bundle: bundle)
    }
}
