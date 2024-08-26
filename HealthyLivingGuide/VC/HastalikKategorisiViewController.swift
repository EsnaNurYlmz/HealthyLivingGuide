//
//  HastalikKategorisiViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 28.06.2024.
//

import UIKit
import Firebase

class HastalikKategorisiViewController: UIViewController {

    @IBOutlet weak var HastalikKategoriTableView: UITableView!
    var hastalikKategoriListesi = [BeslenmeOgeleri]()
    var kategorii : kategori?
    
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        HastalikKategoriTableView.dataSource = self
        HastalikKategoriTableView.delegate = self
        ref = Database.database().reference()
        
        HastalikKategoriTableView.rowHeight = 60
        HastalikKategoriTableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        if let k = kategorii{
            navigationItem.title = k.kategori_ad
            HastalikKategoriGetir(kategori_ad:k.kategori_ad!)
        }
    }
    
    
    func HastalikKategoriGetir(kategori_ad:String){
        let sorgu = ref.child("HastalikKategorisi").queryOrdered(byChild: "kategori_ad").queryEqual(toValue: kategori_ad)
        sorgu.observe(.value, with: { snapshot in
            if let gelenVeri = snapshot.value as? [String:AnyObject]{
                self.hastalikKategoriListesi.removeAll()
                for gelenVeriSatiri in gelenVeri {
                    if let dictionary = gelenVeriSatiri.value as? NSDictionary {
                        let id = gelenVeriSatiri.key
                        let isim = dictionary["isim"] as? String ?? " "
                        let resim = dictionary["resim"] as? String ?? " "
                        let bilgi = dictionary["bilgi"] as? String ?? " "
                        let  kategori_ad = dictionary["kategori_ad"] as? String ?? " "
                        
                        let hastalikKategorisi = BeslenmeOgeleri(isim: isim, resim: resim, id: id, bilgi: bilgi, kategori_ad: kategori_ad)
                        self.hastalikKategoriListesi.append(hastalikKategorisi)
                        
                        
                    }
                }
            }
            DispatchQueue.main.async {
                self.HastalikKategoriTableView.reloadData()
                
            }
        } )
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! HastaliklarViewController
        gidilecekVC.hastalik = hastalikKategoriListesi[indeks!]
    }
    
}
extension HastalikKategorisiViewController: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hastalikKategoriListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kategoriler = hastalikKategoriListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HastalikKategoriHucre", for: indexPath) as! HastalikKategoriHucreTableViewCell
        cell.HastalikKategoriHucreLabel.text = kategoriler.isim
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toHastaliklar", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

