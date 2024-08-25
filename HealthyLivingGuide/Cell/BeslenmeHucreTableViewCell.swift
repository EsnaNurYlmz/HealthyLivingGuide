//
//  BeslenmeHucreTableViewCell.swift
//  HealthyLivingGuide
//
//  Created by Esna nur Yılmaz on 1.07.2024.
//

import UIKit

class BeslenmeHucreTableViewCell: UITableViewCell {

    @IBOutlet weak var BeslenmeKategoriLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        BeslenmeKategoriLabel.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    // titleLabel'in dikeyde ortalanması
                    BeslenmeKategoriLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    // titleLabel'in leading ve trailing kenarlarına kısıtlama eklemek
                    BeslenmeKategoriLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    BeslenmeKategoriLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
                ])
    }
}
