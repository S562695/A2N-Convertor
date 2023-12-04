//
//  signUpVC.swift
//  AN Convertor
//
//  Created by Naga Lakshmi on 11/26/23.
//

import UIKit
import Lottie
import Firebase
import Lottie
import AnimatedGradientView

class signUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        self.applyAnimatedGradient()
        logoAnimationView.animation = LottieAnimation.named("registerImg")
                logoAnimationView.loopMode = .loop
                logoAnimationView.play(){
                    [weak self] _ in
                    self?.logoAnimationView.isHidden = false
                }
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
        

        // Do any additional setup after loading the view.
    }
    
    private func applyAnimatedGradient(){
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BCOE4", "#EAECC6"], .up, .axial),
                                            (colors: ["#833ab4", "#fd1d1d", "fcb045"], .right, .axial),
                                            (colors: ["#003973", "#E6E68E"], .down, .axial),
                                            (colors: ["#1E9600", "#FFF200", "FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.insertSubview(animatedGradient, at: 0)
        

    }
    
    @IBOutlet weak var logoAnimationView: LottieAnimationView!
    
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var dobField: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    @IBOutlet weak var signUpBTN: UIButton!
    
    @IBOutlet weak var resetBTN: UIButton!
    
    @IBOutlet weak var errorLBL: UILabel!
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        signUp()
    }
    
    @IBAction func resetClicked(_ sender: UIButton) {
        firstNameTF.text = ""
        lastNameTF.text = ""
        dobField.text = ""
        emailTF.text = ""
        passwordTF.text = ""
        confirmPasswordTF.text = ""
        errorLBL.text = ""
        errorLBL.isHidden = true
    }
    
    private func setupDatePicker() {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            dobField.inputView = datePicker

            datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobField.text = dateFormatter.string(from: sender.date)
    }
    
    private func signUp() {
            guard let firstName = firstNameTF.text,
                  let lastName = lastNameTF.text,
                  let dob = dobField.text,
                  let email = emailTF.text,
                  let password = passwordTF.text,
                  let confirmPassword = confirmPasswordTF.text
            else {
                return
            }

            // Check if passwords match
            guard password == confirmPassword else {
                showError(message: "Passwords do not match")
                return
            }

            // Additional validations can be added as needed

            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    self?.showError(message: error.localizedDescription)
                } else {
                    
                    let alert = UIAlertController(title: "SignUp Status", message: "Your Account has been created Successfully, Please login to Continue ☺️ ", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title:"OK", style: .default) { (action) in self?.performSegue(withIdentifier: "loginSegue", sender: self)
                    }
                    alert.addAction(okAction)

                    self?.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
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
