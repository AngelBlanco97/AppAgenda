//
//  Secciones.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class Secciones: NSObject {
    
    var cabecera: String
    var items: [Objetos]
    
    
    init(titulo: String, objetos: [Objetos]) {
        
        cabecera = titulo
        items = objetos
    }


}
