//
//  UIView+PolioPager.swift
//  PolioPager
//
//  Created by Yuiga Wada on 2019/11/28.
//  Copyright © 2019 Yuiga Wada. All rights reserved.
//

import UIKit

internal extension UIView {
    var allSubviews: [UIView] {
        return subviews + subviews.flatMap { $0.allSubviews }
    }
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
