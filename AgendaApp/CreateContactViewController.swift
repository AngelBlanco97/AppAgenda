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
        
        //Recogemos los valores de tenga guardados en userdefault de su propia agenda y los decodamos.
        if let data = userDefault.object(forKey: "Agenda") as? Data {
            let decoder = JSONDecoder()
            if let personas = try? decoder.decode([Contacto].self, from: data) {
                // Recorremos la cantidad de personas que tiene en la agenda, y los añadimos al array interno de Agenda para persistir los datos.
                for person in personas {
                    Agenda.append(person)
                }
            }
        }
    }
    
    
    
    @IBAction func crearUsuario(_ sender: Any) {
        
        // Recogemos los valores de los textfield de la persona que quiere agregar.
        guard let nombre = txt_Nombre.text else {return}
        guard let apellidos = txt_Apellidos.text else {return}
        guard let telefono = txt_Telefono.text else {return}
        guard let contacto = txt_Contacto.text else {return}
        guard let fechaNac = txt_FechaNacimiento.text else {return}

        //Creamos un objecto persona con los valores que ha añadido y lo añadimos al array de contactos que habiamos iniciado previamente con los datos persistidos
        let nuevoUsuario = Contacto(foto: "", nombre: nombre, apellidos: apellidos, telefono: telefono, contacto: contacto, fechanacimiento: fechaNac)
        Agenda.append(nuevoUsuario)
        
        
        //Codificamos el array y lo volvemos a guardar en userdefault con los cambios nuevos.
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(Agenda) {
            userDefault.set(data, forKey: "Agenda")
        }
        
        // Cambio de pantalla a la tabla de contactos automáticamente
        self.navigationController?.popViewController(animated: true)

        
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
