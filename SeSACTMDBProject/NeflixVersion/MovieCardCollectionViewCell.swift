//
//  MovieCardCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/09.
//

import UIKit

class MovieCardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCardCollectionViewCell"

    @IBOutlet weak var movieCardView: MovieCardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        movieCardView.backgroundColor = .clear
        movieCardView.posterImageView.backgroundColor = .lightGray
    }
    

}
