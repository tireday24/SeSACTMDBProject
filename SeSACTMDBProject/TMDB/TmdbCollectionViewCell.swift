//
//  TmdbCollectionViewCell.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/03.
//

import UIKit

class TmdbCollectionViewCell: UICollectionViewCell {
    static let identifier = "TmdbCollectionViewCell"

    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var clipButton: UIButton!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var gradeViewLable: UILabel!
    @IBOutlet weak var nameTotalLabel: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var detailLabelView: UILabel!
    @IBOutlet weak var clipBackgroundView: UIView!
    @IBOutlet weak var gradeStackView: UIStackView!
    
    func configure() {
        curveView.clipsToBounds = true
        curveView.layer.cornerRadius = 5
        shadowView.layer.cornerRadius = 5
        shadowView.clipsToBounds = true
        shadowView.layer.borderColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowPath = nil
        shadowView.layer.shadowOffset = .init(width: -20, height: -10)
        shadowView.layer.shadowRadius = 20
        clipBackgroundView.layer.cornerRadius = clipBackgroundView.frame.height / 2
        clipBackgroundView.layer.borderWidth = 1
        clipBackgroundView.clipsToBounds = true
        gradeStackView.layer.borderWidth = 1
        
        
    }
}
