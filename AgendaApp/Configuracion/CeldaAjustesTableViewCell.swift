//
//  CeldaAjustesTableViewCell.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class CeldaAjustesTableViewCell: UITableViewCell {
    //MARK: TableView Default
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: OUTLETS CELDA-AJUSTES
    @IBOutlet weak var iconimg: UIImageView!
    @IBOutlet weak var txt_Contenido: UILabel!

}
