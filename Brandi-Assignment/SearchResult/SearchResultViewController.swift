//
//  ViewController.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import UIKit

protocol SearchResultDelegate: AnyObject {
    func presentVC()
}

class SearchResultViewController: UIViewController {
    @IBOutlet weak var searchView: SearchResultView!
    
    let viewModel = SearchResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.setViewModel(viewModel)
        viewModel.delegate = self
    }
}

extension SearchResultViewController: SearchResultDelegate {
    func presentVC() {
        guard let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController else { return }
        imageVC.setViewModel(viewModel)
        modalPresentationStyle = .fullScreen
        self.present(imageVC, animated: true, completion: nil)
    }
    
}
