//
//  UIImageView+Extension.swift
//  BookStore
//
//  Created by amir on 18.11.2020.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(urlStr: String) {
        let placeHolderImage = #imageLiteral(resourceName: "placeholderImage")
        guard let url = URL(string: urlStr) else {
            self.image = placeHolderImage            
            return
        }
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.flipFromLeft(0.5)),
                .cacheOriginalImage
            ], completionHandler: { result in }
        )
    }
}
