//
//  MovieCardViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/09.
//

import UIKit

import Kingfisher

class MovieCardViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var recommendList: [[String]] = []

    let colorList: [UIColor] = [.red, .systemPink, .lightGray, .yellow, .black, .systemRed, .green, .systemBlue, .brown, .orange]
    
//    let numberList: [[Int]] = [
//        [Int](1...10),
//        [Int](11...20),
//        [Int](21...30),
//        [Int](31...40),
//        [Int](41...50),
//        [Int](51...60),
//        [Int](61...70),
//        [Int](71...80),
//        [Int](81...90),
//        [Int](91...100)
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        TMDBAPIManager.shared.requestImage { recommend in
            self.recommendList = recommend
            self.mainTableView.reloadData()
        }
        

    }

}

extension MovieCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recommendList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCardTableViewCell.identifier, for: indexPath) as? MovieCardTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.movieCollectionView.backgroundColor = .clear
        cell.movieCollectionView.delegate = self
        cell.movieCollectionView.dataSource = self
        cell.movieCollectionView.register(UINib(nibName: MovieCardCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCardCollectionViewCell.identifier)
        cell.movieCollectionView.tag = indexPath.section
        cell.movieCollectionView.reloadData()
        cell.titleLabel.text = "\(TMDBAPIManager.shared.movieList[indexPath.section].0) Similar Contents!"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension MovieCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendList[collectionView.tag].count
        //return numberList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCardCollectionViewCell.identifier, for: indexPath) as? MovieCardCollectionViewCell else { return UICollectionViewCell()}

        cell.movieCardView.posterImageView.backgroundColor = .black
        let url = URL(string: "\(TMDBAPIManager.shared.imageURL)\(recommendList[collectionView.tag][indexPath.item])")
        cell.movieCardView.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    
    
}
