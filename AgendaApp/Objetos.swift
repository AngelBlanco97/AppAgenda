//
//  Objetos.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class Objetos: NSObject {
    
    var title: String
    var colors: UIColor
    var icon: String
    var controller: String
    
    init(texto: String, color: UIColor, icono: String, vc: String){
        title = texto
        colors = color
        icon = icono
        controller = vc
    }
        
}
