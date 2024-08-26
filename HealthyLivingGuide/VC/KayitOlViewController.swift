//
//  KayitOlViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 27.06.2024.
//

import UIKit
import FirebaseAuth
import Firebase

class KayitOlViewController: UIViewController {
    
    @IBOutlet weak var SifreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var TekrarSifreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SifreTextField.isSecureTextEntry = true
        TekrarSifreTextField.isSecureTextEntry = true
    }
    @IBAction func kayitOlButton(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
              let sifre = SifreTextField.text, !sifre.isEmpty,
              let tekrarsifre = TekrarSifreTextField.text, !tekrarsifre.isEmpty,
              sifre == tekrarsifre else {
            print("Lütfen tüm alanları doldurunuz.")
            return
        }
        Auth.auth().createUser(withEmail: email, password:sifre){ authResult, error in
            if let error = error {
                print("Kayıt hatası: \(error.localizedDescription)")
                print("Hatalı kayıt oluşturdunuz.")
                self.showErrorAlert(message: error.localizedDescription)
            } else {
                print("Kayıt başarılı")
                self.saveUserToFirestore(email: email)
                self.performSegue(withIdentifier: "toGiriss", sender: nil)
            }
        }
    }
    func saveUserToFirestore(email: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(uid).setData([
            "email": email,
            "createdAt": FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                print("Veritabanına kayıt hatası: \(error.localizedDescription)")
                self.showErrorAlert(message: error.localizedDescription)
                
            } else {
                print("Kullanıcı veritabanına başarıyla kaydedildi")
            }
        }
    }
    func showErrorAlert(message: String) {
            let alertController = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
}
