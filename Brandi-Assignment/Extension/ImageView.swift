//
//  ImageView.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/28.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageUrl(_ urlString: String) {
        kf.setImage(with: URL(string: urlString), placeholder: nil, options: nil, completionHandler: nil)
    }
}
