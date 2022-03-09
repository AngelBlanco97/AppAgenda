//
//  ThemeViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class ThemeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: OUTLETS
    @IBOutlet weak var txt_Theme: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var btn_guardar: UIButton!
    
    //MARK: VARIABLES
    private var theme = ["Modo Claro", "Modo Oscuro"]
    private var themeSelected = ""
    public var userDefault = UserDefaults.standard
    
   
    //MARK: VIEW
    
    /*
     Delegamos el picker view tras la carga de la vista.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: PICKER DELEGATE Y PICKER DATA
    
    /*
     Numero de componentes según la información aportada (Solo queremos mostrar un conjunto de datos)
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    /*
     Devolvemos la cantidad de filas que tendrá el picker según la cantidad del conjunto de datos.
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theme.count
    }
    
    /*
     Devolvemos el contenido de la posición del array que se relaciona con la fila.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return theme[row]
    }
    
    /*
     En caso de cambiar la posición activa del picker, devolvemos el valor en el momento seteando los estilos con esa configuración y lo guardamos en la variable privada de la clase.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_Theme.text = theme[row]
        themeSelected = theme[row]
    }
    
    /*
     En caso de clickarse botón añadimos la información de la variable temporal privada a las preferencias de usuario. Devolvemos al usuario a la vista principal.
     */
    @IBAction func guardarTheme(_ sender: Any) {
        userDefault.set(self.themeSelected, forKey: "Theme")
        self.navigationController?.popViewController(animated: true)
    }

}
