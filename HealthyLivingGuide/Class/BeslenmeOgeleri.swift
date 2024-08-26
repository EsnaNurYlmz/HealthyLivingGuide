//
//  BeslenmeOgeleri.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 12.07.2024.
//


import Foundation

class BeslenmeOgeleri {
    
    var isim : String?
    var id : String?
    var resim  : String?
    var bilgi : String?
    var kategori_ad : String?
    
    init(isim: String , resim: String ,  id: String ,  bilgi: String , kategori_ad: String ) {
        self.isim = isim
        self.id = id
        self.resim = resim
        self.bilgi = bilgi
        self.kategori_ad = kategori_ad
        
    }
}


