//
//  SizeListadoViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class SizeListadoViewController: UIViewController {
    
    
    //MARK: OUTLETS
    @IBOutlet weak var txt_prueba: UILabel!
    @IBOutlet weak var input_size: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btn_guardar: UIButton!
    
    //MARK: VARIABLES
    private var valueSize: Int = 15
    private let userDefault = UserDefaults.standard
    
    //MARK: VIEW
    
    /*
     Recogemos las preferencias de usuario sobre el tamaño de fuente, y lo asignamos a la variable de clase privada, seteamos los estilos con esa información si existiese.
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
     Si el valor del stepper cambia, seteamos los estilos con esa configuración y lo asignamos a la variable privada de clase.
     */
    @IBAction func valueChanged(_ sender: UIStepper) {
        input_size.text = Int(sender.value).description
        self.valueSize = Int(sender.value)
        txt_prueba.font = UIFont(name: "Arial", size: CGFloat(Int(sender.value)))
    }
    
    /*
     Recogemos las preferencias de usuario sobre el tamaño de la fuente, si existe se guarda en la variable privada, si no, no continúa.
     */
    func recogidaDatos() {
        guard let size = userDefault.object(forKey: "SizeListado") as? Int else {return}
        self.valueSize = size
    }
    
    
    /*
     Si el usuario hace la acción en el botón, recogemos los valores y los guardamos en las preferencias de usuario. Devolvemos al usuario a la raiz de la navegación. 
     */
    @IBAction func guardarSize(_ sender: Any) {
        userDefault.set(self.valueSize, forKey: "SizeListado")
        
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
