//
//  HastalikliBeslenmeViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 28.06.2024.
//

import UIKit
import Firebase
    
class HastalikliBeslenmeViewController : UIViewController {
    
    @IBOutlet weak var HastalikliBeslenmeTableView: UITableView!
    
    var kategoriListesi = [kategori]()
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        HastalikliBeslenmeTableView.delegate = self
        HastalikliBeslenmeTableView.dataSource = self
        HastalikliBeslenmeTableView.rowHeight = UITableView.automaticDimension
        HastalikliBeslenmeTableView.estimatedRowHeight = 60
        tumKategorileriAl()
    }
    
    func tumKategorileriAl(){
        ref.child("Hastalikkategoriler").observe(.value , with: { snapshot in
            if let gelenVeri = snapshot.value as? [Any]{
                self.kategoriListesi.removeAll()
                for case let kategoriData as [String: Any] in gelenVeri where kategoriData != nil {
                    if let kategoriAd = kategoriData["kategori_ad"] as? String,
                       let kategoriID = kategoriData["kategori_id"] as? String {
                        let kategori = kategori(kategori_id: kategoriID, kategori_ad: kategoriAd)
                        self.kategoriListesi.append(kategori)
                    }
                }
            }
            DispatchQueue.main.async {
                self.HastalikliBeslenmeTableView.reloadData()
            }
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHastalikKategorisi",
           let indeks = sender as? Int,
           let gidilecekVC = segue.destination as? HastalikKategorisiViewController{
            gidilecekVC.kategorii = kategoriListesi[indeks]
        }
    }
}
    extension HastalikliBeslenmeViewController: UITableViewDelegate , UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return kategoriListesi.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let kategoriler = kategoriListesi[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HastalikHucre", for: indexPath) as! HastalikHucreTableViewCell
            cell.HastalikKategoriLabel.text = kategoriler.kategori_ad
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: "toHastalikKategorisi", sender: indexPath.row)
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
        }
    }
    


