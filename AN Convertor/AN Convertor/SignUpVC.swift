//
//  SignUpVC.swift
//  AN Convertor
//
//  Created by Naga Lakshmi on 11/21/23.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
    
        // Hide the error label
        errorLBL.alpha = 0
    
        // Style the elements
        Utilities.styleTextField(firstNameTF)
        Utilities.styleTextField(lastNameTF)
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleFilledButton(signUpBTN)
    }
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var signUpBTN: UIButton!
    
    @IBOutlet weak var errorLBL: UILabel!
    
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = firstNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.performSegue(withIdentifier: "loginsegue", sender: self)
                }
                
            }
        }
    }
    
    
    func showError(_ message:String) {
        
        errorLBL.text = message
        errorLBL.alpha = 1
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
