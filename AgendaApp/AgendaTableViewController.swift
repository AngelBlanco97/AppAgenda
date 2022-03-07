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
    private var fuente: String = ""
    private var color = UIColor(named: "")
    private var sizeList = CGFloat(15)
    private var isTheme = ""
    
    
    // 0 = FAMILIA, 1 = TRABAJO, 2 = AMIGOS

    
    //MARK: VIEWLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setTheme()
        recogidaInformacion()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setStyle()
        setTheme()
        recogidaInformacion()
        miTabla.reloadData()
    }

    
    
    //MARK: USERDEFAULTS STYLES
    func setStyle() {
        //SETTING FONT STYLE
        self.fuente = userDefault.object(forKey: "Fuente") as? String ?? ""
        
        //SETTING COLOR FONT STYLE
        let colorSeleccionado = userDefault.object(forKey: "Color") as? String ?? ""
        self.color = UIColor(named: colorSeleccionado)
        
        //SETTING FONT SIZE STYLE
        let sizeletter = userDefault.object(forKey: "SizeListado") as? CGFloat ?? self.sizeList
        self.sizeList = CGFloat(sizeletter)
        
        
        //SETTING THEME STYLE
        let theme = userDefault.object(forKey: "Theme") as? String ?? ""
        self.isTheme = theme
    }
    
    func setTheme() {
        if (self.isTheme == "Modo Claro") {
            if #available(iOS 13.0, *) {
                UIApplication.shared.delegate?.window??.overrideUserInterfaceStyle = .light
            }
            self.color = UIColor(named: "LetraCelda")
        }
        
        if (self.isTheme == "Modo Oscuro") {
            if #available(iOS 13.0, *) {
                UIApplication.shared.delegate?.window??.overrideUserInterfaceStyle = .dark
            }
            self.color = UIColor(named: "LetraCelda")
        }
    }
    
    
    //MARK: DATOS
    
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
    
    private func setNewAgenda() {
        //Creamos un array con los diferentes tipos actualizados
        let contactos: [Contacto] = arrayFamilia + arrayAmigos + arrayTrabajo
        
        //Codificamos el array y lo volvemos a guardar en userdefault con los cambios nuevos implementados.
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(contactos) {
            userDefault.set(data, forKey: "Agenda")
        }

        
    }
    
    
    
    
    // MARK: SEGMENT CONTROL
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
            cell.backgroundColor = UIColor(named: "FondoCelda")
            cell.img.image = UIImage(systemName: "person")
            cell.nombreCompleto.font = UIFont(name: self.fuente, size: self.sizeList)
            cell.nombreCompleto.textColor = self.color
            cell.nombreCompleto.text = String(arrayFamilia[indexPath.row].nombre)
            cell.telefono.text = String(arrayFamilia[indexPath.row].telefono)
            cell.telefono.font = UIFont(name: self.fuente , size: self.sizeList)
            cell.telefono.textColor = self.color
            cell.apellido.text = String(arrayFamilia[indexPath.row].apellidos)
            cell.apellido.font = UIFont(name: self.fuente , size: self.sizeList)
            cell.apellido.textColor = self.color
        case 1:
            cell.backgroundColor = UIColor(named: "FondoCelda")
            cell.img.image = UIImage(systemName: "person")
            cell.nombreCompleto.text = String(arrayTrabajo[indexPath.row].nombre)
            cell.telefono.text = String(arrayTrabajo[indexPath.row].telefono)
            cell.apellido.text = String(arrayTrabajo[indexPath.row].apellidos)
            cell.nombreCompleto.font = UIFont(name: self.fuente, size: self.sizeList)
            cell.nombreCompleto.textColor = self.color
            cell.telefono.font = UIFont(name: self.fuente, size: self.sizeList)
            cell.telefono.textColor = self.color
            cell.apellido.font = UIFont(name: self.fuente, size: self.sizeList)
            cell.apellido.textColor = self.color
        case 2:
            cell.backgroundColor = UIColor(named: "FondoCelda")
            cell.img.image = UIImage(systemName: "person")
            cell.nombreCompleto.text = String(arrayAmigos[indexPath.row].nombre)
            cell.telefono.text = String(arrayAmigos[indexPath.row].telefono)
            cell.apellido.text = String(arrayAmigos[indexPath.row].apellidos)
            cell.nombreCompleto.font = UIFont(name: self.fuente, size: self.sizeList)
            cell.nombreCompleto.textColor = self.color
            cell.telefono.font = UIFont(name: self.fuente, size: self.sizeList)
            cell.telefono.textColor = self.color
            cell.apellido.font = UIFont(name: self.fuente , size: self.sizeList)
            cell.apellido.textColor = self.color
        default:
            return UITableViewCell()
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Creamos una accion de borrado
        let deleteRow  = UIContextualAction(style: .normal, title: "Borrar") {(action, view, completion) in completion(true)
        
            // Creamos el alert de borrado que determinara si quiere realizar la accion en concreto. Si cancela no se realiza, si acepta, se elimina.
            let deleteAlert = UIAlertController(title: "Borrar contacto", message: "¿Estas seguro de eliminar este contacto?", preferredStyle: .alert)
            deleteAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            deleteAlert.addAction(UIAlertAction(title: "Confirmar", style: .destructive, handler: { action in
            
                // Dependiendo del segmento de control en el que este, eliminamos la celda de su array concreto, y persistimos los datos en userdefaults
                let segmentSelected = self.segmentControl.selectedSegmentIndex
                switch segmentSelected {
                case 0:
                    self.arrayFamilia.remove(at: indexPath.row)
                    self.miTabla.deleteRows(at: [indexPath], with: .fade)
                    self.setNewAgenda()
                    self.showAlertDelete()
                case 1:
                    self.arrayTrabajo.remove(at: indexPath.row)
                    self.miTabla.deleteRows(at: [indexPath], with: .fade)
                    self.setNewAgenda()
                    self.showAlertDelete()
                case 2:
                    self.arrayAmigos.remove(at: indexPath.row)
                    self.miTabla.deleteRows(at: [indexPath], with: .fade)
                    self.setNewAgenda()
                    self.showAlertDelete()
                default:
                    self.showAlertProblem()
                }
            
            }))
            
            //Presentamos la alerta de borrado
            self.present(deleteAlert,animated: true,completion: nil)
            
        }
        
        //Ponemos estilo a la accion de borrado y lo ponemos como una configuracion del movimiento
        deleteRow.backgroundColor = UIColor(ciColor: .red)
        deleteRow.image = UIImage(systemName: "trash")
        let config = UISwipeActionsConfiguration(actions: [deleteRow])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
    
    
    //Function para presentar una alerta en caso de error o por defecto
    func showAlertProblem() {
        let alert = UIAlertController(title: "ERROR", message: "No se ha podido realizar la acción. Por favor, inténtelo de nuevo.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
        
    }
    
    
    // Funcion para presentar una alerta en caso de hacer el eliminado correctamente
    func showAlertDelete() {
        let alert = UIAlertController(title: "Contacto eliminado", message: "El contacto ha sido eliminado satisfactoriamente.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
        
    }
    
    
    // Segue para pasar los datos a una nueva view para acceder a los detalles del contacto
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detailContact") {
            
            let segmentControl = segmentControl.selectedSegmentIndex
            guard let row = miTabla.indexPathForSelectedRow?.row else {return}
            let detailView = segue.destination as! ContactDetailsViewController
            
            
            switch segmentControl {
            case 0:
                let person = arrayFamilia[row]
                detailView.imagen = person.foto
                detailView.id = 0
                detailView.idPerson = row
            case 1:
                let person = arrayTrabajo[row]
                detailView.imagen = person.foto
                detailView.id = 1
                detailView.idPerson = row
            case 2:
                let person = arrayAmigos[row]
                detailView.imagen = person.foto
                detailView.id = 2
                detailView.idPerson = row
            default:
                self.showAlertProblem()
            }
            
            
            
            
        }
    }
    
}
