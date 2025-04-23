//
//  UIImage+Extension.swift
//  SignQuestUI
//
//  Created by Ezra Arya Wijaya on 23/04/25.
//

import SwiftUI

public extension UIImage {
    static func createSolidImage(color: UIColor, size: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
