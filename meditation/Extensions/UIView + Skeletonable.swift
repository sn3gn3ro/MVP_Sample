//
//  UIView + Skeletonable.swift
//  meditation
//
//  Created by Ilya Medvedev on 29.05.2023.
//

import UIKit
import SkeletonView

extension UIView {
    
    func setSkeletonableStyle() {
        self.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.Main.darkViolet, secondaryColor: UIColor.Main.darkVioletLight))
    }
}
