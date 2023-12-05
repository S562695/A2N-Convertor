//
//  StartPageVC.swift
//  AN Convertor
//
//  Created by Naga Lakshmi on 11/21/23.
//

import UIKit
import AVKit
import Lottie
import AnimatedGradientView
class StartPageVC: UIViewController {
    
    
    
    @IBOutlet weak var logoAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*playAnimation()
        // Do any additional setup after loading the view.
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)*/
        

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
        

        playAnimation()
    }
    
    func playAnimation(){
        logoAnimationView.contentMode =  .scaleAspectFit
                   logoAnimationView.loopMode = .loop
                   
                   logoAnimationView.animationSpeed=0.5
                   logoAnimationView.play()
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
