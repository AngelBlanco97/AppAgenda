//
//  ContactDetailsViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        recogidaInformacion()
        rellenar()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recogidaInformacion()
        rellenar()
    }
    
    //MARK: OUTLETS
    @IBOutlet weak var txt_Nombre: UILabel!
    @IBOutlet weak var txt_Apellido: UILabel!
    @IBOutlet weak var txt_telefono: UILabel!
    @IBOutlet weak var txt_contacto: UILabel!
    @IBOutlet weak var txt_fecha: UILabel!
    @IBOutlet weak var img_src: UIImageView!
    
    
    //MARK: VARIABLES
    public var userDefault = UserDefaults.standard
    public var imagen = ""
    public var nombre = ""
    public var apellidos = ""
    public var telefono = ""
    public var contacto = ""
    public var fecha = ""
    public var id = 0
    public var idPerson = 0
    public var arrayFamilia: [Contacto] = []
    public var arrayTrabajo: [Contacto] = []
    public var arrayAmigos: [Contacto] = []
    
    
    //MARK: DATOS
    
    private func recogidaInformacion() {
        
        
        // Recogemos los valores que hay en la agenda por medio de userdefault
        
        if let data = userDefault.object(forKey: "Agenda") as? Data {
            
            arrayAmigos.removeAll()
            arrayTrabajo.removeAll()
            arrayFamilia.removeAll()
            
            
            //Decodificamos los datos a un tipologia de dato [contacto]
            let decoder = JSONDecoder()
            if let personas = try? decoder.decode([Contacto].self, from: data) {
                
                
                //Recorremos la cantidad de contactos que tiene, vamos rellenando los arrays por tipo de contacto
                for persona in personas {

                    if (persona.contacto == "Familia") {
                        arrayFamilia.append(persona)
                    }
                    
                    if (persona.contacto == "Trabajo") {
                        arrayTrabajo.append(persona)
                    }
                    
                    if (persona.contacto == "Amigos") {
                        arrayAmigos.append(persona)
                    }
                    
                }
            }
        }
    }
    
    public func rellenar() {
        
        switch id {
        case 0:
            txt_telefono.text = arrayFamilia[idPerson].telefono
            txt_Nombre.text = arrayFamilia[idPerson].nombre
            txt_fecha.text = arrayFamilia[idPerson].fechanacimiento
            txt_Apellido.text = arrayFamilia[idPerson].apellidos
            txt_contacto.text = arrayFamilia[idPerson].contacto
            img_src.image = UIImage(systemName: "person")
        case 1:
            txt_telefono.text = arrayTrabajo[idPerson].telefono
            txt_Nombre.text = arrayTrabajo[idPerson].nombre
            txt_fecha.text = arrayTrabajo[idPerson].fechanacimiento
            txt_Apellido.text = arrayTrabajo[idPerson].apellidos
            txt_contacto.text = arrayTrabajo[idPerson].contacto
            img_src.image = UIImage(systemName: "person")
        case 2:
            txt_telefono.text = arrayAmigos[idPerson].telefono
            txt_Nombre.text = arrayAmigos[idPerson].nombre
            txt_fecha.text = arrayAmigos[idPerson].fechanacimiento
            txt_Apellido.text = arrayAmigos[idPerson].apellidos
            txt_contacto.text = arrayAmigos[idPerson].contacto
            img_src.image = UIImage(systemName: "person")
        default:
            showAlertProblem()
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "editContact") {
            
            let detailView = segue.destination as! EditContactViewController
            
            detailView.nombre = txt_Nombre.text!
            detailView.apellido = txt_Apellido.text!
            detailView.telefono = txt_telefono.text!
            detailView.contacto = txt_contacto.text!
            detailView.fecha = txt_fecha.text!
            detailView.idArray = id
            detailView.idPerson = idPerson
        }
            
    }
    
    
    
    @IBAction func eliminarUser(_ sender: Any) {
        switch id {
        case 0:
            arrayFamilia.remove(at: idPerson)
            savenewData()
        case 1:
            arrayTrabajo.remove(at: idPerson)
            savenewData()
        case 2:
            arrayAmigos.remove(at: idPerson)
            savenewData()
        default:
            showAlertProblem()
        }
        
    }
    
    
    private func savenewData() {
        //Creamos un array con los diferentes tipos actualizados
        let contactos: [Contacto] = arrayFamilia + arrayAmigos + arrayTrabajo
        
        //Codificamos el array y lo volvemos a guardar en userdefault con los cambios nuevos implementados.
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(contactos) {
            userDefault.set(data, forKey: "Agenda")
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    //Function para presentar una alerta en caso de error o por defecto
    func showAlertProblem() {
        let alert = UIAlertController(title: "ERROR", message: "No se ha podido realizar la acción. Por favor, inténtelo de nuevo.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
        
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
