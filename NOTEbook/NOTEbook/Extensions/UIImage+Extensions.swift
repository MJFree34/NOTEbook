//
//  UIImage+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 6/17/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

extension UIImage {
    static func drawStaffLine(color: UIColor, size: CGSize, rounded: Bool) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        var img = renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)
            ctx.cgContext.fill(CGRect(origin: .zero, size: size))
        }
        
        if rounded {
            let imageView = UIImageView(frame: CGRect(origin: .zero, size: size))
            imageView.contentMode = .center
            imageView.image = img
            imageView.layer.cornerRadius = min(size.height, size.width) / 2
            
            let imageViewRenderer = UIGraphicsImageRenderer(size: size)
            
            img = imageViewRenderer.image { ctx in
                imageView.layer.render(in: ctx.cgContext)
            }
        }
        
        return img
    }
}
