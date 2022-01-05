//
//  ViewController.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import UIKit

protocol SearchResultDelegate: AnyObject {
    func presentVC(_ viewModel: SearchResultViewModel)
}

class SearchResultViewController: UIViewController {
    @IBOutlet weak var searchView: SearchResultView!
    
    let viewModel = SearchResultViewModel.EMPTY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
}

extension SearchResultViewController: SearchResultDelegate {
    func presentVC(_ viewModel: SearchResultViewModel) {
        guard let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController else { return }
        imageVC.setViewModel(viewModel)
        self.present(imageVC, animated: true, completion: nil)
    }
    
}
