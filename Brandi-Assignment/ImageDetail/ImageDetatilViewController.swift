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
    
    private var viewModel = ImageDetailViewModel.EMPTY
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let document = viewModel.document
        let index = viewModel.index
        imageView.setImageUrl(document[index].image_url)
        siteName.text = document[index].display_sitename
        dateTime.text = viewModel.dateFormat(document[index].datetime)
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
