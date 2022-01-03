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
    
    private var viewModel = ImageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.setImageUrl(viewModel.document[viewModel.index].image_url)
        siteName.text = viewModel.document[viewModel.index].display_sitename
        dateTime.text = viewModel.dateFormat(viewModel.document[viewModel.index].datetime)
    }
}

extension ImageDetailViewController {
    /// viewModel Set
    func setViewModel(_ viewModel: SearchResultViewModel?) {
        guard let _vm = viewModel else { return }
            self.viewModel = ImageDetailViewModel(api: _vm.apiManager,
                                                  search: _vm.searchOption,
                                                  isFetchingMore: _vm.isFetchingMore,
                                                  document: _vm.savedData,
                                                  index: _vm.index)
    }
}
