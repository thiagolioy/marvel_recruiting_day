//
//  UIImage+Kingfisher.swift
//  Marvel
//
//  Created by Thiago Lioy on 20/11/16.
//  Copyright © 2016 Thiago Lioy. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func download(image url: String) {
        self.sd_setImage(with: URL(string:url))
    }
}
