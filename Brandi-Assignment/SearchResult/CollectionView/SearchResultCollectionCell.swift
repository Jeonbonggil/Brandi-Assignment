//
//  SearchResultCollectionCell.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import UIKit

class SearchResultCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI(_ document: Document) {
        imageView.setImageUrl(document.thumbnail_url)
    }
    
}
