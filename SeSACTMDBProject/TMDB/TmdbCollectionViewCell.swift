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
    
    
    
    func configure() {
        shadowView.clipsToBounds = true
        shadowView.layer.cornerRadius = 20
        curveView.layer.borderColor = UIColor.black.cgColor
        curveView.layer.shadowOpacity = 0.8
        curveView.layer.shadowPath = nil
        curveView.layer.shadowOffset = .init(width: -20, height: -10)
        curveView.layer.shadowRadius = 20
    }
}
