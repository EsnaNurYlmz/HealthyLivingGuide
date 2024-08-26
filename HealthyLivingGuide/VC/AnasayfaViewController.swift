//
//  AnasayfaViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 28.06.2024.
//

import UIKit

class AnasayfaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saglikliBeslenmeButton(_ sender: Any) {
        performSegue(withIdentifier: "toSB", sender: nil)
    }
    
    @IBAction func hastaliksalBeslenmeButton(_ sender: Any) {
        performSegue(withIdentifier: "toHB", sender: nil)
    }
    
}
