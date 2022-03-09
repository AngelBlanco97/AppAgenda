//
//  DataModel.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class DataModel {
    
    func obtenerSecciones() -> [Secciones] {
        
        var seccionesArray = [Secciones] ()
        
        let sizeFont = Secciones(titulo: "TAMAÑO FUENTE", objetos: [Objetos(texto: "Listado de contactos", color: .systemRed, icono: "person.2.fill", vc: "SizeListadoViewController"), Objetos(texto: "Detalle de contacto", color: .systemBlue, icono: "person.fill", vc: "SizeDetailViewController")])
        
        let colorFont = Secciones(titulo: "COLOR FUENTE", objetos: [Objetos(texto: "Color", color: .systemGreen, icono: "paintpalette.fill", vc: "ColorLetterViewController")])
        
        let typeletter = Secciones(titulo: "TIPO LETRA", objetos: [Objetos(texto: "Letra", color: .systemOrange, icono: "scribble", vc: "LetterViewController")])
        
        let theme = Secciones(titulo: "TEMA", objetos: [Objetos(texto: "Tema principal", color: .systemBrown, icono: "paintbrush.fill", vc: "ThemeViewController")])
        
        
        
        seccionesArray.append(sizeFont)
        seccionesArray.append(colorFont)
        seccionesArray.append(typeletter)
        seccionesArray.append(theme)
        
        
        
        return seccionesArray
    }

}
