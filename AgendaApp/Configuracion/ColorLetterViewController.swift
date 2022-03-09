//
//  ColorLetterViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class ColorLetterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: OUTLETS
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txt_prueba: UILabel!
    @IBOutlet weak var btn_Guardar: UIButton!
    
    //MARK: VARIABLES
    private var colorSeleccionado = UIColor(named: "Negro")
    private var colores = ["Negro",  "Azul", "Rojo", "Verde", "Marrón"]
    let userDefault = UserDefaults.standard
    
    
    
    //MARK: PICKER DELEGATE & DATA SOURCE
    
    /*
     Numero de componentes (Solo queremos mostrar uno según la información establecida, es decir solo cogeremos de un array la información)
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    /*
     Devolvemos la cantidad de filas que queremos que se muestren de nuestro array de informacion
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colores.count
    }
    
    /*
     Devolvemos el texto que deseamos que se coloque en cada fila según la posicion del array
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colores[row]
    }
    
    /*
     En caso de cambiarse, la posición de la fila que queda activada, se asigna al texto en el moment para que se vean los cambios y se añaden a la variable privada interna el valor del color.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_prueba.textColor = UIColor(named: colores[row])
        colorSeleccionado = UIColor(named: colores[row])
        
    }
    
    
    //MARK: VIEW
    
    /*
        Cuando la vista cargue, delegamos la información del picker y recogemos la información que pueda existir en USERDEFAULT del usuario para asignar esa información en la pantalla. Seteamos la variables con esa información si existe.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        recogeDatos()
        txt_prueba.textColor = self.colorSeleccionado
    }
    
    /*
     Recogemos los datos del Userdefault y los añadimos a la variable privada de la vista.
     */
    private func recogeDatos() {
        guard let color = userDefault.object(forKey: "Color") as? String else {return}
        self.colorSeleccionado = UIColor(named: color)
    }
    
    
    /*
     En caso de accionar el botón, se guardan los datos que se hayan introducido o estén en ese momento asignados y los guardamos en las preferencias de usuario. Volvemos a la vista principal de navegación.
     */
    @IBAction func guardarColor(_ sender: Any) {
        let color = txt_prueba.textColor
        let nombre = color!.value(forKey: "name")
        
        
        userDefault.set(nombre, forKey: "Color")

        self.navigationController?.popViewController(animated: true)
    }

}
