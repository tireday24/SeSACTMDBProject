//
//  SearchNameViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class SearchNameViewController: UIViewController {
    
    static let identifier = "SearchNameViewController"
    var movieList: [TmdbInfo] = []
    var list: [String] = []
    var totalCount = 0
    var startPage = 1
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        navigationBarUI()
        
    }
    
    func requestAPI() {

    let url = "\(EndPoint.TMDBURL)api_key=\(APIKey.TMDB)&page=\(startPage)"
    
    
    //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
    AF.request(url, method: .get).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            
            self.totalCount = json["total_pages"].intValue
            
            for mv in json["results"] {
                
                let poster = mv.1["poster_path"].stringValue
                let overview = mv.1["overview"].stringValue
                let grade = mv.1["vote_average"].doubleValue
                let genre = mv.1["genre_ids"].arrayObject as! [Int]
                let date = mv.1["release_date"].stringValue
                let title = mv.1["title"].stringValue
                
                
                let id = mv.1["id"].intValue
                let bgImg = mv.1["backdrop_path"].stringValue
                let posterImg = mv.1["poster_path"].stringValue
                let acTitle = mv.1["title"].stringValue
                
                //let castView = mv.1["overview"].stringValue
                
                
                let info = TmdbInfo(releaseDate: date, movieTitle: title, moviePoster: poster, voteAverage: "\(round(grade * 100) / 100.0)", overview: overview, genre: genre, id: id, backgroundImg: bgImg, posterImg: posterImg, actorTitle: acTitle)
                
                
                self.movieList.append(info)
            }
            
            
            self.collectionView.reloadData()
            
        case .failure(let error):
            print(error)
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmdbCollectionViewCell.identifier, for: indexPath) as? TmdbCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.movieNameLabel.text = list[indexPath.item]
        
        return cell
    }
}

extension SearchNameViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.list = self.movieList.filter($0.lowercased().contains(text))
        self.collectionView.reloadData()
    }
    
}
