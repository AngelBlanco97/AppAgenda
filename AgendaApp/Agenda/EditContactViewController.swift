//
//  EditContactViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class EditContactViewController: UIViewController {
    
    //MARK: VARIABLES
    public var nombre = ""
    public var apellido = ""
    public var telefono = ""
    public var contacto = ""
    public var fecha = ""
    public var idArray = 0
    public var idPerson = 0
    public var userDefault = UserDefaults.standard
    public var arrayAmigos: [Contacto] = []
    public var arrayFamilia: [Contacto] = []
    public var arrayTrabajo: [Contacto] = []
    let typeContact = ["Familia", "Trabajo", "Amigos"]
    let contactType = UIPickerView()
    var nombreNuevo: String = ""
    var apellidoNuevo: String = ""
    var telefonoNuevo: String = ""
    var contactoNuevo: String = ""
    var fechaNueva: String = ""
    
    //MARK: OUTLETS
    @IBOutlet weak var txt_Nombre: UITextField!
    @IBOutlet weak var txt_Apellidos: UITextField!
    @IBOutlet weak var txt_Telefono: UITextField!
    @IBOutlet weak var txt_contacto: UITextField!
    @IBOutlet weak var txt_fecha: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholder()
        
        //DELEGAMOS EL PICKER DE TIPO DE CONTACTO PARA EXTENDERLO DE LA CLASE AL FINAL
        contactType.delegate = self
        contactType.dataSource = self
        txt_contacto.inputView = contactType
        
        // Creamos el datepicker para poder dar fecha con la misma tipologia.
        let fechaNacimiento = UIDatePicker()
        fechaNacimiento.datePickerMode = .date
        fechaNacimiento.addTarget(self,action: #selector(nacimientoDateChange(datePicker:)), for: UIControl.Event.valueChanged)
        fechaNacimiento.frame.size = CGSize(width: 0, height: 300)
        fechaNacimiento.preferredDatePickerStyle = .wheels
        txt_fecha.inputView = fechaNacimiento
        
        
        recogidaInformacion()
        
        
        
        print(idArray)
        print(idPerson)
        // Do any additional setup after loading the view.
    }
    
    //MARK: DATOS
    
    private func recogidaInformacion() {
        
        // Recogemos los valores que hay en la agenda por medio de userdefault
        
        if let data = userDefault.object(forKey: "Agenda") as? Data {
            // Vaciamos los array previamente para evitar duplicidad de datos.
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
    
    
    private func setPlaceholder() {
        //Seteamos los datos del segue
        txt_Nombre.placeholder = nombre
        txt_Apellidos.placeholder = apellido
        txt_Telefono.placeholder = telefono
        txt_contacto.placeholder = contacto
        txt_fecha.placeholder = fecha
    }

    
    @objc func nacimientoDateChange(datePicker: UIDatePicker) {
        txt_fecha.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func guardarCambios(_ sender: Any) {
        
        
        
        // Comprobamos que si no se ha puesto ningun texto, entendemos que el usuario no quiere cambiar los valores, por lo que recogemos el placeholder
        if ((txt_Nombre.text?.isEmpty) == true) {
            self.nombreNuevo = txt_Nombre.placeholder!
        } else {
            self.nombreNuevo = txt_Nombre.text!
        }
        
        if ((txt_Apellidos.text?.isEmpty) == true) {
            self.apellidoNuevo = txt_Apellidos.placeholder!
        } else {
            self.apellidoNuevo = txt_Apellidos.text!
        }
        
        if ((txt_Telefono.text?.isEmpty) == true) {
            self.telefonoNuevo = txt_Telefono.placeholder!
        } else {
            self.telefonoNuevo = txt_Telefono.text!
        }
        
        if ((txt_contacto.text?.isEmpty) == true) {
            self.contactoNuevo = txt_contacto.placeholder!
        } else {
            self.contactoNuevo = txt_contacto.text!
        }
        
        if ((txt_fecha.text?.isEmpty) == true) {
            self.fechaNueva = txt_fecha.placeholder!
        } else {
            self.fechaNueva = txt_fecha.text!
        }
        
        
        //Eliminamos temporalmente el usuario que ha decidido editar
        switch idArray {
        case 0:
            arrayFamilia.remove(at: idPerson)
        case 1:
            arrayTrabajo.remove(at: idPerson)
        case 2:
            arrayAmigos.remove(at: idPerson)
        default:
            showAlertProblem()
        }
        
        
        let contacto = Contacto(foto: "", nombre: nombreNuevo, apellidos: apellidoNuevo, telefono: telefonoNuevo, contacto: contactoNuevo, fechanacimiento: fechaNueva)
        
        //Añadimos de nuevo el contacto al array segun el contexto de su tipo de contacto. Puede cambiar la tipologia del contacto, por lo que ese sera el motivo de su guardado de nuevo.
        switch contactoNuevo {
        case "Familia":
            arrayFamilia.append(contacto)
        case "Trabajo":
            arrayTrabajo.append(contacto)
        case "Amigos":
            arrayAmigos.append(contacto)
        default:
            showAlertProblem()
        }
        
        //Guardamos los valores en userdefaults
        changeData()
        
        
        //Volvemos a la pantalla anterior con los cambios actualizados
        cambioPantalla()
    }
    
    private func changeData() {
        //Creamos un array con los diferentes tipos de contacto pero ya actualizados
        let contactos: [Contacto] = arrayFamilia + arrayAmigos + arrayTrabajo
        
        //Codificamos el array y lo volvemos a guardar en userdefault con los cambios nuevos implementados.
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(contactos) {
            userDefault.set(data, forKey: "Agenda")
        }

        
    }
    
    /*
     Cambiamos de pantalla a la principal al llamar a la funcion
     */
    private func cambioPantalla() {
        self.navigationController?.popViewController(animated: true)
    }


    
    //Function para presentar una alerta en caso de error o por defecto
    func showAlertProblem() {
        let alert = UIAlertController(title: "ERROR", message: "No se ha podido realizar la acción. Por favor, inténtelo de nuevo.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
        
    }
}


//Extendemos del controlador para delegar el picker
extension EditContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeContact.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeContact[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_contacto.text = typeContact[row]
        txt_contacto.resignFirstResponder()
    }
}
