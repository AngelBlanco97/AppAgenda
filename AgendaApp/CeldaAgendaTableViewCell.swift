//
//  CeldaAgendaTableViewCell.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import UIKit

class CeldaAgendaTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: OUTLETS
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var nombreCompleto: UILabel!
    @IBOutlet weak var apellido: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
