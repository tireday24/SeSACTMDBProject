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

class TmdbViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    var movieList: [TmdbInfo] = []
    var keyList: [Int : String] = [:]
    let genreSingleton = Genre.shared
    var startPage = 1
    var totalCount = 0
    var requestId = 0
    var requestOverview = ""
    var requestImg = ""
    var backgroundImg = ""
    var posterImg = ""
    var actorTitle = ""
    var key = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        naviBarButtonDesign()
        requestAPI()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        layout()
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
    
    
    func forwardButtonClicked() {
        //chevron.forward
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
    
    func videoAPI(id: Int, compltionHandler: @escaping (String) -> ()) {
        let url = EndPoint.videoURL + "\(id)" + EndPoint.videoLink + APIKey.TMDB
        
    //접두어 -> AF 알라모파이어에서 url주소로 들어가고 get 방식 유효성 검사(상태코드) 실행 ex) 200 = 성공 response 데이터 가져오겠다
    AF.request(url, method: .get).validate().responseData { response in
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            print("JSON: \(json)")
        
            compltionHandler(json["results"][0]["key"].stringValue)
            
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

extension TmdbViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmdbCollectionViewCell.identifier, for: indexPath) as? TmdbCollectionViewCell else { return UICollectionViewCell()}
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormat.date(from: movieList[indexPath.item].releaseDate)
        dateFormat.dateFormat = "MM/dd/yy"
        let movieReleaseDate = dateFormat.string(from: newDate!)
        
        cell.releaseDataLabel.text = movieReleaseDate
        
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
        
        cell.configure()
        
        cell.clipButton
        
        cell.clipButton.tag = indexPath.item
        cell.clipButton.addTarget(self, action: #selector(clipButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Cast", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: CastViewController.identifier) as? CastViewController else {return}
        
        vc.castId = movieList[indexPath.item].id

        vc.castOverview = movieList[indexPath.item].overview
        
        vc.bgUrl = movieList[indexPath.item].backgroundImg
        vc.posterUrl = movieList[indexPath.item].posterImg
        vc.castTitle = movieList[indexPath.item].actorTitle
        
         let nv = UINavigationController(rootViewController: vc)
         nv.modalPresentationStyle = .fullScreen
         self.present(nv, animated: true)
        
    }
    
    
}


extension TmdbViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    
        for indexPath in indexPaths {
            if movieList.count - 1 == indexPath.item && movieList.count < totalCount{
                startPage += 1
                requestAPI()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension TmdbViewController {

    @objc func clipButtonClicked(sender: UIButton) {

        videoAPI(id: movieList[sender.tag].id) { key in
        let sb = UIStoryboard(name: "WebView", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: WebViewController.identifer) as? WebViewController else { return }
        vc.videoKey = key
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true)

    }

}
}
