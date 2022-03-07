//
//  SizeListadoViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class SizeListadoViewController: UIViewController {
    
    
    
    @IBOutlet weak var txt_prueba: UILabel!
    @IBOutlet weak var input_size: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btn_guardar: UIButton!
    private var valueSize: Int = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input_size.text = txt_prueba.font.pointSize.description
        txt_prueba.font = UIFont(name: "Arial", size: 15)
        stepper.value = 15
        stepper.maximumValue = 25
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        input_size.text = Int(sender.value).description
        self.valueSize = Int(sender.value)
        txt_prueba.font = UIFont(name: "Arial", size: CGFloat(Int(sender.value)))
    }
    
    
    
    @IBAction func guardarSize(_ sender: Any) {
        
        
        let userdefault = UserDefaults.standard
        userdefault.set(self.valueSize, forKey: "SizeListado")
        
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
