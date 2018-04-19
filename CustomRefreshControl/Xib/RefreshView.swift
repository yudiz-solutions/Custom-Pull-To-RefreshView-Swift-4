//
//  RefreshView.swift
//  CustomRefreshControl
//
//  Created by Yudiz on 18/04/18.
//  Copyright © 2018 Yudiz. All rights reserved.
//

import UIKit

/// RefreshView
class RefreshView: UIView {
    
    /// IBOutlets
    @IBOutlet weak var imgVBG: UIImageView!
    @IBOutlet weak var imgVLogo: UIImageView!
    
    /// Variable Declarations
    var gradientView: UIView!
}

// MARK: - UI Related
extension RefreshView {
    
    fileprivate func initializeGradientView() {
        gradientView = UIView(frame: CGRect(x: -30, y: 0, width: 100, height: 60))
        imgVLogo.addSubview(gradientView)
        gradientView.layer.insertSublayer(gradientColor(frame: gradientView.bounds), at: 0)
        gradientView.backgroundColor = UIColor.clear
    }
    
    fileprivate func gradientColor(frame: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 0, y: 0.5)
        layer.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        return layer
    }
    
    func startAnimation() {
        initializeGradientView()
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.gradientView.frame.origin.x = 100
        }, completion: nil)
    }
    
    func stopAnimation() {
        gradientView.layer.removeAllAnimations()
        gradientView = nil
    }
}
