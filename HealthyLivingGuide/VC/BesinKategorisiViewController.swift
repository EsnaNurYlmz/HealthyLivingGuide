//
//  BesinKategorisiViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 28.06.2024.
//

import UIKit
import Firebase

class BesinKategorisiViewController: UIViewController {
    
    @IBOutlet weak var BesinKategorisiTableView: UITableView!
    var besinKategoriListesi = [BeslenmeOgeleri]()
    var besinkategori : kategori?
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BesinKategorisiTableView.dataSource = self
        BesinKategorisiTableView.delegate = self
        ref = Database.database().reference()
        BesinKategorisiTableView.rowHeight = UITableView.automaticDimension
        BesinKategorisiTableView.estimatedRowHeight = 60
        if let k = besinkategori{
            navigationItem.title = k.kategori_ad
            BesinKategoriGetir(kategori_ad:k.kategori_ad!)
        }
    }
    
    func BesinKategoriGetir(kategori_ad:String){
        let sorgu = ref.child("BeslenmeKategorisi").queryOrdered(byChild: "kategori_ad").queryEqual(toValue: kategori_ad)
        sorgu.observe(.value, with: { snapshot in
            if let gelenVeri = snapshot.value as? [String:AnyObject]{
                self.besinKategoriListesi.removeAll()
                for gelenVeriSatiri in gelenVeri {
                    if let dictionary = gelenVeriSatiri.value as? NSDictionary {
                        let id = gelenVeriSatiri.key
                        let isim = dictionary["isim"] as? String ?? ""
                        let resim = dictionary["resim"] as? String ?? ""
                        let bilgi = dictionary["bilgi"] as? String ?? ""
                        let  kategori_ad = dictionary["kategori_ad"] as? String ?? ""
                        let hastalikKategorisi = BeslenmeOgeleri(isim: isim, resim: resim, id: id, bilgi: bilgi, kategori_ad: kategori_ad)
                        self.besinKategoriListesi.append(hastalikKategorisi)
                      }
                    }
                }
            DispatchQueue.main.async {
             self.BesinKategorisiTableView.reloadData()
            }
        })
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! BesinlerViewController
        gidilecekVC.besin = besinKategoriListesi[indeks!]
    }
}

extension BesinKategorisiViewController:  UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return besinKategoriListesi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kategorii = besinKategoriListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BesinKategoriCell", for: indexPath) as! BesinKategoriTableViewCell
        cell.BesinKategoriLabel.text = kategorii.isim
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toBesinler", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

