//
//  SaglikliBeslenmeViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 28.06.2024.
//

import UIKit
import Firebase

class SaglikliBeslenmeViewController: UIViewController {
    
    @IBOutlet weak var saglikliBeslenmeTableView: UITableView!
    var kategorilerListe = [kategori]()
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saglikliBeslenmeTableView.dataSource = self
        saglikliBeslenmeTableView.delegate = self
        
        ref = Database.database().reference()
        
        saglikliBeslenmeTableView.rowHeight = UITableView.automaticDimension
        saglikliBeslenmeTableView.estimatedRowHeight = 100
        tumaKategorileriAl()
    }
    func tumaKategorileriAl(){
        ref.child("Saglikkategoriler").observe(.value, with: { snapshot in
            if let gelenVeri = snapshot.value as? [Any]{
                self.kategorilerListe.removeAll()
                for case let kategoriData as [String: Any] in gelenVeri where kategoriData != nil {
                    if let kategoriAd = kategoriData["kategori_ad"] as? String,
                       let kategoriID = kategoriData["kategori_id"] as? String {
                        let kategori = kategori(kategori_id: kategoriID, kategori_ad: kategoriAd)
                        self.kategorilerListe.append(kategori)
                    }
                }
            }
            DispatchQueue.main.async {
                self.saglikliBeslenmeTableView.reloadData()
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBesinKategorisi",
           let indeks = sender as? Int,
           let gidilecekVC = segue.destination as? BesinKategorisiViewController {
            gidilecekVC.besinkategori = kategorilerListe[indeks]
        }
    }
    
}
extension SaglikliBeslenmeViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kategorilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategoriler = kategorilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "beslenmeHucre", for: indexPath) as! BeslenmeHucreTableViewCell
        cell.BeslenmeKategoriLabel.text = kategoriler.kategori_ad
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toBesinKategorisi", sender: indexPath.row)
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
    
    }

    
    
    
    
    
    
    
    

