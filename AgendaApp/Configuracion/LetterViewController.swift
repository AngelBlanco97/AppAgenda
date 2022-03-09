//
//  LetterViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class LetterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: OUTLETS
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txt_prueba: UILabel!
    
    //MARK: Variables
    public let userDefault = UserDefaults.standard
    public var fuenteActual = "Verdana"
    private var fuentes = ["Copperplate", "Zapfino", "Thonburi", "Verdana", "TimesNewRomanPSMT", "TamilSangamMN"]
    
    
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
        return fuentes.count
    }
    
    /*
     Devolvemos el contenido de la posición del array que se relaciona con la fila.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fuentes[row]
    }
    
    /*
     En caso de cambiar la posición activa del picker, devolvemos el valor en el momento seteando los estilos con esa configuración.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_prueba.font = UIFont(name: fuentes[row], size: 26)
        txt_prueba.text = fuentes[row]
    }
    
    
    //MARK: VIEW
    /*
     Delegamos el picker view tras la carga de la vista y setemos los estilos según las preferencias de usuario.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        setLetter()
        // Do any additional setup after loading the view.
    }
    
    /*
     Buscamos en las preferencias de usuario si existe una configuración preferida de fuente y si existe, la usamos.
     */
    func setLetter() {
        guard let font = userDefault.object(forKey: "Fuente") as? String else {return}
        self.fuenteActual = font
        txt_prueba.text = font
    }
    
    
    /*
     En caso de clickarse botón añadimos la información del texto a las preferencias de usuario. Devolvemos al usuario a la vista principal.
     */
    @IBAction func guardarLetra(_ sender: Any) {
        let fuente = txt_prueba.font.familyName
        userDefault.set(fuente, forKey: "Fuente")
        self.fuenteActual = fuente

        self.navigationController?.popViewController(animated: true)
    }
    
   


}
