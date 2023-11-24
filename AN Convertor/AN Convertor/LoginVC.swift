//
//  LoginVC.swift
//  AN Convertor
//
//  Created by Naga Lakshmi on 11/21/23.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLBL.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleFilledButton(loginBTN)
        
    }
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBTN: UIButton!
    
    @IBOutlet weak var errorLBL: UILabel!
    
    @IBAction func loginClicked(_ sender: UIButton) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLBL.text = error!.localizedDescription
                self.errorLBL.alpha = 1
            }
            else {
                let HomeVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.HomeVC) as? HomeVC
                self.view.window?.rootViewController = HomeVC
                self.view.window?.makeKeyAndVisible()
            }
        }
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
