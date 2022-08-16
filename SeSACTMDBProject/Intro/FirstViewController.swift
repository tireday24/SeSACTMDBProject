//
//  FirstViewController.swift
//  SeSACTMDBProject
//
//  Created by 권민서 on 2022/08/16.
//

import UIKit
import TmdbFrameWork

class FirstViewController: UIViewController {
    
    @IBOutlet weak var tLable: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUI()

       
    }
    
    func setUI() {
        tLable.text = "T"
        tLable.textAlignment = .center
        tLable.alpha = 0
        UIView.animate(withDuration: 3) {
            self.tLable.alpha = 1
        } completion: { _ in
            self.labelViewAnimation() //또 에니메이션 넣기
        }
        tLable.font = .boldSystemFont(ofSize: 300)
        stopButton.tintColor = .white
        stopButton.setTitle("오늘 하루 보지 않기", for: .normal)
        stopButton.layer.borderWidth = 2
        stopButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func labelViewAnimation() {
        UIView.animate(withDuration: 2, delay: 3) {
            self.tLable.alpha = 1
        }
    }
    
    @IBAction func stopButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Tmdb", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: TmdbViewController.reuseIdentifier) as? TmdbViewController else {return }
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true)
        
    }
    
}
