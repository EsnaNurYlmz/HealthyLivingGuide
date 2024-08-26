//
//  ViewController.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 27.06.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func KayitOlButton(_ sender: Any) {
        performSegue(withIdentifier: "toKayit", sender: nil)
    }
    @IBAction func GirişYapButton(_ sender: Any) {
        performSegue(withIdentifier: "toGiris", sender: nil)
    }

}

