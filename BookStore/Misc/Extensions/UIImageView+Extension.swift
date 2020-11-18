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
        let url = URL(string: urlStr)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        //                     |> RoundCornerImageProcessor(cornerRadius: 20)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler: { result in }
        )
    }
}
