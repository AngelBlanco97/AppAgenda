//
//  CeldaAjustesTableViewCell.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class CeldaAjustesTableViewCell: UITableViewCell {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var iconimg: UIImageView!
    @IBOutlet weak var txt_Contenido: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
