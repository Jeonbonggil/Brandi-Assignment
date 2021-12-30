//
//  ImageDetatilViewController.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/28.
//

import Foundation
import UIKit

class ImageDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    var viewModel = SearchResultViewModel()
    var data: Document? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = data {
            imageView.setImageUrl(data.image_url )
            siteName.text = data.display_sitename
            dateTime.text = viewModel.dateFormat(date: data.datetime)
        }
    }
}
