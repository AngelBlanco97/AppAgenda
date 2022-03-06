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
        
        
        
        // Do any additional setup after loading the view.
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
    
    @objc func nacimientoDateChange(datePicker: UIDatePicker) {
        txt_FechaNacimiento.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
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

//Extendemos el controlador para delegar el picker y la informacion del mismo
extension CreateContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        txt_Contacto.text = typeContact[row]
        txt_Contacto.resignFirstResponder()
    }
}
