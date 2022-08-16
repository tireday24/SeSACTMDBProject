//
//  OverviewTableViewCell.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/04.
//

import UIKit
import TmdbFrameWork

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    override func awakeFromNib() {
        expandButton.tintColor = .black
    }
    
}
