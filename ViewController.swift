//
//  ViewController.swift
//  EViOS1
//
//  Created by Student05 on 01/06/2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var myIndicator: UIActivityIndicatorView!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var passwordButton: UIButton!
    
    @IBOutlet var avatarImage: UIImageView!
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var welcomLabel: UILabel!
    
    @IBOutlet var loginTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var newsSwitch: UISwitch!
    
    var hidden:Bool = true
    
    let alertError = UIAlertController(title: "Error", message: "Une condition n'est pas respectée", preferredStyle: .alert)
    
    
    override func viewDidAppear(_ animated: Bool) {
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height/2
    }
    
    @IBAction func showPassword(_ sender: Any) {
        if(hidden == true){
            passwordTextField.isSecureTextEntry = false
            passwordButton.setImage(UIImage(named: "eye_off_icon"), for: .normal)
            hidden = false
        }else{
            passwordTextField.isSecureTextEntry = true
            passwordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
            hidden = true
        }
    }
    
    
    @IBAction func didPressLoginButton(_ sender: Any) {
      
        if let login = loginTextField.text{
            if let password = passwordTextField.text{
                if(password.count > 4 && login.contains("@")){
                    myIndicator.isHidden = false
                    myIndicator.startAnimating()
                    if(newsSwitch.isOn){
                        appel(login: login, password: password) { (user) in
                            DispatchQueue.main.async {
                                self.myIndicator.isHidden = true
                                let  alertConfirm =  UIAlertController(title: "Bienvenue \(login)", message: "Vous vous êtes inscrits à la newsletter", preferredStyle: .alert)
                                alertConfirm.addAction(UIAlertAction(title: "Merci !", style: .default, handler: { action in print("TOUCH Merci !")
                                }))
                                
                                self.present(alertConfirm, animated: true, completion: nil)
                            }
                            
                        }
                    }else {
                        appel(login: login, password: password) { (user) in
                            DispatchQueue.main.async {
                                self.myIndicator.isHidden = true
                                let  alertConfirm =  UIAlertController(title: "Bienvenue \(login)", message: "Vous ne vous êtes pas inscrits à la newsletter", preferredStyle: .alert)
                                alertConfirm.addAction(UIAlertAction(title: "Merci !", style: .default, handler: { action in print("TOUCH Merci !")
                                }))
                                
                                self.present(alertConfirm, animated: true, completion: nil)
                            }
                        }
                        
                    }
                }else {
                    present(alertError, animated: true, completion: nil)

                }
            }else{
                present(alertError, animated: true, completion: nil)

            }
        }else{
            present(alertError, animated: true, completion: nil)
        }
    }

    func appel(login: String, password:String, completionHandler: @escaping(User) -> ()){
        DispatchQueue.global(qos: .background).async {
            sleep(3)
            let user = User(login: self.loginTextField.text ?? " ", password: self.passwordTextField.text ?? " ")
            completionHandler(user)
        }
    }
    
    struct User{
        var login:String
        var password:String
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        myIndicator.isHidden = true
        backgroundImage.contentMode = .scaleAspectFill
        avatarImage.backgroundColor = .green

        welcomLabel.text = "Bienvenue"
        loginTextField.placeholder = "Login"
        loginTextField.keyboardType = .emailAddress
        passwordTextField.placeholder = "Password"
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
        loginButton.backgroundColor = .green
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 5
        newsSwitch.isOn = false
        let tapOnView = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        alertError.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in print("TOUCH OK")
        }))
        view.addGestureRecognizer(tapOnView)
    }
    
    


}

