//
//  loginVC.swift
//  AN Convertor
//
//  Created by Naga Lakshmi on 11/26/23.
//

import UIKit
import Lottie
import Firebase
import AnimatedGradientView

class loginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        playAnimation()
        applyAnimatedGradient()
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
        

//       // logoAnimationView.animation = LottieAnimation.named("Animation")
//        logoAnimationView.loopMode = .loop
//        logoAnimationView.play(){
//            [weak self] _ in
//            self?.logoAnimationView.isHidden = false
//        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.subviews.first?.frame=self.view.bounds
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.subviews.first!.removeFromSuperview()
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
    
     func applyAnimatedGradient(){
         let animatedGradient = AnimatedGradientView(frame: view.bounds)
                 animatedGradient.direction = .up
                 animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
                 (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
                 (colors: ["#003973", "#E5E5BE"], .down, .axial),
                 (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
                 view.insertSubview(animatedGradient, at: 0)
    }
    
    @IBOutlet weak var logoAnimationView: LottieAnimationView!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var notARobotButton: UIButton!
    
    @IBOutlet weak var robotCheck: UISwitch!
    
    @IBAction func notARobotButtonClicked(_ sender: UIButton) {
        robotCheck.isOn = true
    }
    
    @IBOutlet weak var loginBTN: UIButton!
    
    @IBOutlet weak var resetBTN: UIButton!
    
    @IBOutlet weak var errorLBL: UILabel!
    
    @IBAction func loginClicked(_ sender: UIButton) {
        if robotCheck.isOn {
                    login()
                } else {
                    showError(message: "Please verify that you are not a robot.")
                }
    }
    
    private func login() {
            guard let email = emailTF.text,
                  let password = passwordTF.text
            else {
                return
            }

            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    self?.showError(message: error.localizedDescription)
                } else {
                    // User successfully logged in
                    // You can navigate to another screen or perform additional actions
                    self?.performSegue(withIdentifier: "homeSegue", sender: self)
                }
            }
        }
    
    @IBAction func resetClicked(_ sender: UIButton) {
        emailTF.text = ""
        passwordTF.text = ""
        errorLBL.text = ""
        errorLBL.isHidden = true
        //isNotARobotVerified = false
    }
    
    func playAnimation(){
        logoAnimationView.contentMode =  .scaleAspectFit
                   logoAnimationView.loopMode = .loop
                   
                   logoAnimationView.animationSpeed=0.5
                   logoAnimationView.play()
    }
    
    private func showError(message: String) {
             errorLBL.text = message
             errorLBL.isHidden = false
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
