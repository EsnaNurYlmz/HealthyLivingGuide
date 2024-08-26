//
//  GirisYapViewController.swift
//  HealthyLivingGuide
//  Created by Esna nur Yılmaz on 27.06.2024.
//

import UIKit
import FirebaseAuth


class GirisYapViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        sifreTextField.isSecureTextEntry = true
    }
    
    @IBAction func GirisButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
                      let sifre = sifreTextField.text, !sifre.isEmpty else {
                         print("Lütfen tüm alanları doldurun.")
                          return
                }
        Auth.auth().signIn(withEmail: email , password: sifre) { authResult , error in
            if let error = error {
                print("Giriş hatası: \(error.localizedDescription)")
                print("Hatalı giriş yaptınız!")
            }else{
                print("Giriş başarılı")
                self.performSegue(withIdentifier: "toAnasayfa", sender: nil)
            }
        }
    }
}


