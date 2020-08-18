//
//  UIRefreshControl+extension.swift
//  viper-sample
//
//  Created by hicka04 on 2018/08/13.
//  Copyright © 2018 hicka04. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    
    func beginRefreshingManually(in scrollView: UIScrollView) {
        beginRefreshing()
        let offset = CGPoint.init(x: 0, y: -frame.size.height)
        scrollView.setContentOffset(offset, animated: true)
    }
}
