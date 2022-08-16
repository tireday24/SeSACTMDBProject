//
//  MovieCardCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/09.
//

import UIKit
import TmdbFrameWork

class MovieCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieCardView: MovieCardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        movieCardView.contentLabel.text = "Being Ready"
//    }
    
    func setupUI() {
        movieCardView.backgroundColor = .clear
        movieCardView.posterImageView.backgroundColor = .lightGray
    }
    

}
