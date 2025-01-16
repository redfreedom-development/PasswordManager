//
//  ViewController.swift
//  PasswordManager
//
//  Created by Tardes on 13/1/25.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func createAcount(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: txtUser.text!, password: txtPassword.text!) { authResult, error in
                   if let error = error {
                       // Hubo un error
                       print(error)
                       
                       let alertController = UIAlertController(title: "Create user", message: error.localizedDescription, preferredStyle: .alert)

                       alertController.addAction(UIAlertAction(title: "OK", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                   } else {
                       // Todo correcto
                       print("User signs up successfully")
                       
                       let alertController = UIAlertController(title: "Create user", message: "User created successfully", preferredStyle: .alert)

                       alertController.addAction(UIAlertAction(title: "OK", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                   }
               }
    }
        
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: txtUser.text!, password: txtPassword.text!) { [unowned self] authResult, error in
                 //guard let strongSelf = self else { return }
                   if let error = error {
                       // Hubo un error
                       print(error)
                       
                       let alertController = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)

                       alertController.addAction(UIAlertAction(title: "OK", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                   } else {
                       // Todo correcto
                       print("User signs in successfully")
                       self.performSegue(withIdentifier: "goToHome", sender: txtUser.text)
                   }
               }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            if let destinationVC = segue.destination as? ViewControllerHome {
                destinationVC.userLogin = sender as! String
            }
        }
    }

}

