//
//  TmdbViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class TmdbViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList: [TmdbInfo] = []
    let genreSingleton = Genre.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(genreSingleton.genre, "ffffffffffff")
        naviBarButtonDesign()
        requestAPI()
        collectionView.delegate = self
        collectionView.dataSource = self
        layout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmdbCollectionViewCell.identifier, for: indexPath) as? TmdbCollectionViewCell else { return UICollectionViewCell()}
        
        cell.releaseDataLabel.text = movieList[indexPath.item].releaseDate
        
        var genreArray: [String] = []
        
        for i in movieList[indexPath.item].genre{
            genreArray.append(genreSingleton.genre[i] ?? "none")
            
        }
        cell.genreLabel.text = genreArray.formatted()
        
        let url = URL(string: "\(EndPoint.imgURL)\(movieList[indexPath.item].moviePoster)")
        cell.posterImageView.kf.setImage(with: url)
    
        cell.gradeViewLable.text = movieList[indexPath.item].voteAverage
        cell.movieNameLabel.text = movieList[indexPath.item].movieTitle
        cell.overViewLabel.text = movieList[indexPath.item].overview
        
        let data = movieList[indexPath.item]
        cell.configure()
        
        return cell
    }
    

    func naviBarButtonDesign() {
        let item = navigationItem
        item.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(listbuttonClicked))
        item.leftBarButtonItem?.tintColor = .blue
        item.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightButtonClicked))
        
    }
    
    func layout() {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 10
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width , height: (width * 1.2))
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 100
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    @objc func listbuttonClicked() {
        
    }
    
    @objc func rightButtonClicked() {
        
    }
    
    func clipButtonClicked() {
        //paperclip
    }
    
    func forwardButtonClicked() {
        //chevron.forward
    }
    
    func requestAPI() {

    let url = "\(EndPoint.TMDBURL)api_key=\(APIKey.TMDB)"
    
    
    //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
    AF.request(url, method: .get).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
            
            for mv in json["results"] {
                let poster = mv.1["poster_path"].stringValue
                let overview = mv.1["overview"].stringValue
                let grade = mv.1["vote_average"].doubleValue
                let genre = mv.1["genre_ids"].arrayObject as! [Int]
                let date = mv.1["release_date"].stringValue
                let title = mv.1["title"].stringValue
                
                
                let info = TmdbInfo(releaseDate: date, movieTitle: title, moviePoster: poster, voteAverage: "\(round(grade * 100) / 100.0)", overview: overview, genre: genre)
                
                self.movieList.append(info)
            }
            
            self.collectionView.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
}
    
    
    @IBAction func detailButtonClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func forwardButtonClicked(_ sender: UIButton) {
    }
    
}


