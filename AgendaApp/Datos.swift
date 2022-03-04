//
//  Datos.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import Foundation

//Estructura de datos de un contacto.
struct Contacto: Codable {
    let foto: String
    let nombre: String
    let apellidos: String
    let telefono: String
    let contacto: String
    let fechanacimiento: String
}

