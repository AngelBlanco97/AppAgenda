//
//  ContactDetailsViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    //MARK: VIEW
    
    /*
     Cuando carga la vista, seteamos los estilos configurados del usuario, y recogemos la inforamación que se va a rellenar en la tabla.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setFontSize()
        setFontColor()
        recogidaInformacion()
        rellenar()
        // Do any additional setup after loading the view.
    }
    
    /*
     Antes de cargar la vista, seteamos los estilos configurados del usuario, y recogemos la inforamación que se va a rellenar en la tabla para asegurar los datos.
     */
    override func viewDidAppear(_ animated: Bool) {
        setFontSize()
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
    public var sizeLetter = 15.0
    public var colorLetter = UIColor(named: "Black")
    
    
    
    //MARK: STYLE
    /*
     Seteamos el tamaño de la fuente buscando en la configuración del usuario que pueda tener. Si no existe, sale.
     */
    private func setFontSize() {
        guard let tamaño = userDefault.object(forKey: "SizeDetail") as? Int else {return}
        self.sizeLetter = CGFloat(tamaño)
    }
    
    /*
     Seteamos la fuente que el usuario tenga guardada en su configuración. Si no existe, sale.
     */
    private func setFontColor() {
        guard let color = userDefault.object(forKey: "Color") as? String else {return}
        self.colorLetter = UIColor(named: color)
    }
    
    
    //MARK: DATOS
    
    private func recogidaInformacion() {
        
        
        // Recogemos los valores que hay en la agenda por medio de userdefault
        
        if let data = userDefault.object(forKey: "Agenda") as? Data {
            
            //Eliminamos los datos que puedan estar en el array para asegurar que no se dupliquen.
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
    
    
    /*
     Rellenamos los datos según el id del modelo de datos de la tabla que ha sido pulsada. 0 para familia, 1 para trabajo, 2 para amigos.
     Seteamos los estilos correspondientes que tengamos guardados al buscar en sus preferencias de usuario.
     */
    public func rellenar() {
        
        switch id {
        case 0:
            txt_telefono.text = arrayFamilia[idPerson].telefono
            txt_Nombre.text = arrayFamilia[idPerson].nombre
            txt_fecha.text = arrayFamilia[idPerson].fechanacimiento
            txt_Apellido.text = arrayFamilia[idPerson].apellidos
            txt_contacto.text = arrayFamilia[idPerson].contacto
            txt_telefono.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_telefono.textColor = self.colorLetter
            txt_Nombre.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_Nombre.textColor = self.colorLetter
            txt_fecha.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_fecha.textColor = self.colorLetter
            txt_Apellido.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_Apellido.textColor = self.colorLetter
            txt_contacto.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_contacto.textColor = self.colorLetter
            img_src.image = UIImage(systemName: "person")
        case 1:
            txt_telefono.text = arrayTrabajo[idPerson].telefono
            txt_Nombre.text = arrayTrabajo[idPerson].nombre
            txt_fecha.text = arrayTrabajo[idPerson].fechanacimiento
            txt_Apellido.text = arrayTrabajo[idPerson].apellidos
            txt_contacto.text = arrayTrabajo[idPerson].contacto
            txt_telefono.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_Nombre.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_fecha.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_Apellido.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_contacto.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_telefono.textColor = self.colorLetter
            txt_Nombre.textColor = self.colorLetter
            txt_fecha.textColor = self.colorLetter
            txt_Apellido.textColor = self.colorLetter
            txt_contacto.textColor = self.colorLetter
            img_src.image = UIImage(systemName: "person")
        case 2:
            txt_telefono.text = arrayAmigos[idPerson].telefono
            txt_Nombre.text = arrayAmigos[idPerson].nombre
            txt_fecha.text = arrayAmigos[idPerson].fechanacimiento
            txt_Apellido.text = arrayAmigos[idPerson].apellidos
            txt_contacto.text = arrayAmigos[idPerson].contacto
            txt_telefono.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_Nombre.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_fecha.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_Apellido.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_contacto.font = UIFont(name: "Arial", size: self.sizeLetter)
            txt_telefono.textColor = self.colorLetter
            txt_Nombre.textColor = self.colorLetter
            txt_fecha.textColor = self.colorLetter
            txt_Apellido.textColor = self.colorLetter
            txt_contacto.textColor = self.colorLetter
            img_src.image = UIImage(systemName: "person")
        default:
            showAlertProblem()
        }
        
        
    }
    
    /*
     Recogemos los valores que se hayan presentado en la vista si el usuario quiere ir a editarlos. Enviando la información a la vista siguiente para que pueda editarlo al gusto. Presentamos la vista de edición.
     */
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
    
    
    /*
     Si clicka en eliminar, eliminamos los datos según el usuario que haya pulsado (amigo, familia, trabajo) del array privado correspondiente y guardamos con savenewData()
     */
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
    
    /*
     Recogemos los datos que esten en los arrays recogidos de las preferencias de usuario, y lo guardamos de nuevo para reescribir la información (con los datos antiguos o nuevos)  Devolvemos al usuario a la vista principal. 
     */
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
}
