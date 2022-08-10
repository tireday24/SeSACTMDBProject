//
//  MovieCardTableViewCell.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/09.
//

import UIKit

class MovieCardTableViewCell: UITableViewCell {
    
    static let identifier = "MovieCardTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
    }
    
    func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "아는 와이프와 비슷한 콘텐츠"
        titleLabel.backgroundColor = .black
        titleLabel.textColor = .white
        
        movieCollectionView.backgroundColor = .clear
        movieCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }

}
