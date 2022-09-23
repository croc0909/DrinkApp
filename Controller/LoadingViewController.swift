//
//  LoadingViewController.swift
//  DrinkApp
//
//  Created by AndyLin on 2022/9/23.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playAnimation()
        // Do any additional setup after loading the view.
    }
    
    func playAnimation(){
        print(String(describing: animationView.animation))
        animationView.animation = Animation.named("loading")
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


