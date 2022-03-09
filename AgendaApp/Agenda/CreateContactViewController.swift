//
//  CreateContactViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import UIKit

class CreateContactViewController: UIViewController {

    //MARK: VIEW
    
    /*
     Cuando la vista cargue, buscamos la informacion que tenga guardada el usuario en sus preferencias, y las asignamos a las variables internas. Creamos los picker asociados a los input (para que cuando clicke en ellos se abran los selectores propios)
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        cargaDatos()
        
        contactType.delegate = self
        contactType.dataSource = self
        txt_Contacto.inputView = contactType
        
        
        let fechaNacimiento = UIDatePicker()
        fechaNacimiento.datePickerMode = .date
        fechaNacimiento.addTarget(self,action: #selector(nacimientoDateChange(datePicker:)), for: UIControl.Event.valueChanged)
        fechaNacimiento.frame.size = CGSize(width: 0, height: 300)
        fechaNacimiento.preferredDatePickerStyle = .wheels
        txt_FechaNacimiento.inputView = fechaNacimiento
        txt_FechaNacimiento.text = formatDate(date: Date())
    }
    
    
    
    
    
    //MARK: VARIABLES
    private var userDefault = UserDefaults.standard
    private var Agenda: [Contacto] = []
    let typeContact = ["Familia", "Trabajo", "Amigos"]
    let contactType = UIPickerView()
    
    
    //MARK: OUTLETS
    @IBOutlet weak var txt_Nombre: UITextField!
    @IBOutlet weak var txt_FechaNacimiento: UITextField!
    @IBOutlet weak var txt_Contacto: UITextField!
    @IBOutlet weak var txt_Telefono: UITextField!
    @IBOutlet weak var txt_Apellidos: UITextField!
    
    
    /*
     Recogemos los datos del usuario de sus contactos.
     */
    
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
    
    /*
     En caso de variar los datos del picker, seteamos el input con el valor que quede seleccionado.
     */
    @objc func nacimientoDateChange(datePicker: UIDatePicker) {
        txt_FechaNacimiento.text = formatDate(date: datePicker.date)
    }
    
    /*
     Formateamos el tipo de dato para que sea siempre el mismo y no lo "decida el usuario" si no que utilice el mismo.
     */
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    
    /*
     Cuando pulsa el botón creamos un usuario nuevo en su agenda.
     */
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
    


}

//Extendemos el controlador para delegar el picker y la informacion del mismo
extension CreateContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    /*
     Retornamos un componente según la información que queremos que se muestre en nuestro conjunto de datos privado tipo de contacto.
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /*
     Devolvemos la cantidad de filas según la cantidad de datos de nuestro conjunto de tipos de contacto
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeContact.count
    }
    /*
     Devolvemos el valor del conjunto de datos según la posición de la fila, asignandose y mostrandose así.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeContact[row]
    }

    /*
     En caso de variar la posición, seteamos el texto con la información contenida en la fila activa. 
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_Contacto.text = typeContact[row]
        txt_Contacto.resignFirstResponder()
    }
}
