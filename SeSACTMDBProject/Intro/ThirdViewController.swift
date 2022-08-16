//
//  ThirdViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/16.
//

import UIKit
import TmdbFrameWork

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        setUI()
       
    }
    
    func setUI() {
        movieLabel.textAlignment = .center
        movieLabel.tintColor = .white
        movieLabel.font = .boldSystemFont(ofSize: 20)
        movieLabel.text = "영화 추천 기능"
        movieImageView.backgroundColor = .clear
        movieImageView.image = UIImage(systemName: "pin")
        movieImageView.tintColor = .white
        stopButton.tintColor = .white
        stopButton.setTitle("시작하기", for: .normal)
        stopButton.layer.borderWidth = 2
        stopButton.layer.borderColor = UIColor.white.cgColor
    }
    
    
    @IBAction func stopButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Tmdb", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TmdbViewController.reuseIdentifier) as? TmdbViewController else {return }
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true)
    }
    
    

}
