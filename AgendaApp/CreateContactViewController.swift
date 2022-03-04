//
//  CreateContactViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import UIKit

class CreateContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        cargaDatos()
        // Do any additional setup after loading the view.
    }
    
    //MARK: VARIABLES
    private var userDefault = UserDefaults.standard
    private var Agenda: [Contacto] = []
    
    //MARK: OUTLETS
    @IBOutlet weak var txt_Nombre: UITextField!
    @IBOutlet weak var txt_FechaNacimiento: UITextField!
    @IBOutlet weak var txt_Contacto: UITextField!
    @IBOutlet weak var txt_Telefono: UITextField!
    @IBOutlet weak var txt_Apellidos: UITextField!
    
    
    private func cargaDatos() {
        if let data = userDefault.object(forKey: "Agenda") as? Data {
            let decoder = JSONDecoder()
            if let personas = try? decoder.decode([Contacto].self, from: data) {
                for person in personas {
                    Agenda.append(person)
                }
            }
        }
    }
    
    
    
    @IBAction func crearUsuario(_ sender: Any) {
        
        
        guard let nombre = txt_Nombre.text else {return}
        guard let apellidos = txt_Apellidos.text else {return}
        guard let telefono = txt_Telefono.text else {return}
        guard let contacto = txt_Contacto.text else {return}
        guard let fechaNac = txt_FechaNacimiento.text else {return}

        
        let nuevoUsuario = Contacto(foto: "", nombre: nombre, apellidos: apellidos, telefono: telefono, contacto: contacto, fechanacimiento: fechaNac)
        Agenda.append(nuevoUsuario)
        
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(Agenda) {
            print(data)
            userDefault.set(data, forKey: "Agenda")
        }
        
        print(nuevoUsuario)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
