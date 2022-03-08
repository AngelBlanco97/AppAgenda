//
//  ColorLetterViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 6/3/22.
//

import UIKit

class ColorLetterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var txt_prueba: UILabel!
    @IBOutlet weak var btn_Guardar: UIButton!
    
    
    private var colorSeleccionado = UIColor(named: "Negro")
    private var colores = ["Negro",  "Azul", "Rojo", "Verde", "Marrón"]
    let userDefault = UserDefaults.standard
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colores.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colores[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txt_prueba.textColor = UIColor(named: colores[row])
        colorSeleccionado = UIColor(named: colores[row])
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        recogeDatos()
        txt_prueba.textColor = self.colorSeleccionado
        // Do any additional setup after loading the view.
    }
    
    private func recogeDatos() {
        guard let color = userDefault.object(forKey: "Color") as? String else {return}
        self.colorSeleccionado = UIColor(named: color)
    }
    
    
    @IBAction func guardarColor(_ sender: Any) {
        let color = txt_prueba.textColor
        let nombre = color!.value(forKey: "name")
        
        
        userDefault.set(nombre, forKey: "Color")

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
