//
//  AgendaTableViewController.swift
//  AgendaApp
//
//  Created by Angel Blanco on 2/3/22.
//

import UIKit

class AgendaTableViewController: UITableViewController {
    
    //MARK: OUTLETS
    @IBOutlet var miTabla: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var btn_Add: UIBarButtonItem!
    
    
    
    //MARK: VARIABLES
    private var arrayFamilia: [Contacto] = []
    private var arrayTrabajo: [Contacto] = []
    private var arrayAmigos: [Contacto] = []
    private var userDefault = UserDefaults.standard
    private var tablaActual = 0
    // 0 = FAMILIA, 1 = TRABAJO, 2 = AMIGOS

    
    //MARK: VIEWLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        recogidaInformacion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recogidaInformacion()
        miTabla.reloadData()
        
    }
    
    
    
    //MARK: CARGA DATOS
    
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
    
    
    @IBAction func cambiaSegmento(_ sender: Any) {
        // Llamamos al reload cada vez que el valor del segmentcontrol cambia para recargar la informacion.
        self.miTabla.reloadData()
    }
    
    

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Según el segment control en el que este, queremos que tome los valores de fila segun el array propio del segmentcontrol
        let segment = self.segmentControl.selectedSegmentIndex
        switch segment {
        case 0:
            return arrayFamilia.count
        case 1:
            return arrayTrabajo.count
        case 2:
            return arrayAmigos.count
        default:
            return 0
        }
        
        
    }
    
    
   

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Segun el segment control en el que este, rellenamos los valores segun el el propio array que lo carga.
        let indexSelected = self.segmentControl.selectedSegmentIndex
        let cell = miTabla.dequeueReusableCell(withIdentifier: "celda") as! CeldaAgendaTableViewCell
        switch indexSelected {
        case 0:
            cell.nombreCompleto.text = String(arrayFamilia[indexPath.row].nombre)
            cell.telefono.text = String(arrayFamilia[indexPath.row].telefono)
        case 1:
            cell.nombreCompleto.text = String(arrayTrabajo[indexPath.row].nombre)
            cell.telefono.text = String(arrayTrabajo[indexPath.row].telefono)
        case 2:
            cell.nombreCompleto.text = String(arrayAmigos[indexPath.row].nombre)
            cell.telefono.text = String(arrayAmigos[indexPath.row].telefono)
        default:
            return UITableViewCell()
        }
        
        return cell
    }


}
