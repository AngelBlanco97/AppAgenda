//
//  SizeDetailViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class SizeDetailViewController: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var txt_prueba: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btn_guardar: UIButton!
    @IBOutlet weak var input_size: UITextField!
    
    //MARK: VARIABLES
    private var valueSize: Int = 15
    
    
    //MARK: VIEW
    
    /*
     Recogemos la informacion de USERDEFAULT si existe, y seteamos los estilos segun la configuracion guardada.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        recogidaDatos()
        txt_prueba.font = UIFont(name: "Arial", size: CGFloat(Int(self.valueSize)))
        input_size.text = txt_prueba.font.pointSize.description
        stepper.value = Double(self.valueSize)
        stepper.maximumValue = 25
    }
    
    /*
     Recogemos los datos guardados para el tamaño de letra de los detalles si existen en UserDefault
     */
    func recogidaDatos() {
        let userDefault = UserDefaults.standard
        guard let size = userDefault.object(forKey: "SizeDetail") as? Int else {return}
        self.valueSize = size
    }
   
    /*
     Recoge la información en caso de cambiar el valor del stepper, setea estilos para verse en el momento el cambio y guarda la informacion en la variable temporal privada
     */
    @IBAction func valuechanged(_ sender: UIStepper) {
        input_size.text = Int(sender.value).description
        self.valueSize = Int(sender.value)
        txt_prueba.font = UIFont(name: "Arial", size: CGFloat(Int(sender.value)))
    }
    
    /*
     En caso de accionarse el botón, recoge los valores que esten en el momento del tamaño en la variable privada. Vuelve a la navegación principal de configuración.
     */
    @IBAction func guardar(_ sender: Any) {
        let userDefault = UserDefaults.standard
        userDefault.set(self.valueSize, forKey: "SizeDetail")
        self.navigationController?.popViewController(animated: true)
    }

}
