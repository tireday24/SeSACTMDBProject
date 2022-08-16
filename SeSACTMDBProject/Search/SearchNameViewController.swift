//
//  SearchNameViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/12.
//

import UIKit
import TmdbFrameWork

import Alamofire
import SwiftyJSON
import Kingfisher

class SearchNameViewController: UIViewController {
    
    var movieList: [String] = []
    var list: [String] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        navigationBarUI()
        
    }
    
    func movieListAPI() {
        SearchMovieAPI.shared.movieListAPI { movie in
            self.list = movie
        }
    }
   

    
    func navigationBarUI() {
        let navi = navigationItem
        navi.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        navi.title = "Search"
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }

}

extension SearchNameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmdbCollectionViewCell.reuseIdentifier, for: indexPath) as? TmdbCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.movieNameLabel.text = movieList[indexPath.item]
        
        return cell
    }
}

extension SearchNameViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.movieList = self.list.filter{$0.lowercased().contains(text)}
        self.collectionView.reloadData()
    }
    
}
