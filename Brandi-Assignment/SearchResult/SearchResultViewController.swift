//
//  ViewController.swift
//  Brandi-Assignment
//
//  Created by Bonggil Jeon on 2021/12/27.
//

import UIKit

protocol SearchResultDelegate: AnyObject {
    func sendData(_ data: Document)
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
    func sendData(_ data: Document) {
        guard let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailViewController") as? ImageDetailViewController else { return }
        
        imageVC.data = data
        modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            self.present(imageVC, animated: true, completion: nil)
        }
    }
    
}
