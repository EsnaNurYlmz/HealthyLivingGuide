//
//  HastalikKategorisi.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 2.07.2024.
//

import Foundation

class BeslenmeOgeleri {
    
    var isim : String?
    var resim  : String?
    var bilgi : String?
    var kategori_ad : String?
    
    init(isim: String , resim: String , bilgi: String , kategori_ad: String ) {
        self.isim = isim
        self.resim = resim
        self.bilgi = bilgi
        self.kategori_ad = kategori_ad
    }
}

