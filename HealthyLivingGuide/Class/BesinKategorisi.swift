//
//  BesinKategorisi.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 3.07.2024.
//

import Foundation
 
class BesinKategorisi {
    
    var besinKategori_ad : String?
    var besinKategori_id : String?
    var kategori_ad : String?
    var besin_image : String?
     
    init(besinKategori_ad: String, besinKategori_id: String, kategori_ad: String, besin_image: String) {
        self.besinKategori_ad = besinKategori_ad
        self.besinKategori_id = besinKategori_id
        self.kategori_ad = kategori_ad
        self.besin_image = besin_image
    }
    
    
    
}
