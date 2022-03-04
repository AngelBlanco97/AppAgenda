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
        if let data = userDefault.object(forKey: "Agenda") as? Data {
            arrayAmigos.removeAll()
            arrayTrabajo.removeAll()
            arrayFamilia.removeAll()
            
            let decoder = JSONDecoder()
            if let personas = try? decoder.decode([Contacto].self, from: data) {
                
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
        self.miTabla.reloadData()
    }
    
    

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let segment = self.segmentControl.selectedSegmentIndex
        switch segment {
        case 0:
            return arrayFamilia.count
        case 1:
            return arrayTrabajo.count
        case 2:
            return arrayAmigos.count
        default:
            return 2
        }
        
        
    }
    
    
   

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
