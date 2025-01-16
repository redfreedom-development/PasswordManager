import UIKit
import FirebaseFirestore


class AddRegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btSave: UIButton!
    @IBOutlet weak var txtOtro: UITextField!
    
    let db = Firestore.firestore()
    var userLogin: String = ""
 


    let pickerView = UIPickerView() // Creamos el UIPickerView
    let opciones = ["Apple", "Gmail", "Hotmail", "Microsotf","Netflix","Amazon","YouTube","Spotify","Otros"] // Valores predefinidos

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOtro.isHidden=true
        lbUser.text=userLogin
        print ("el usuario logado es: \(userLogin)")
        
        // Asignar delegados del pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Asignar el pickerView como inputView del UITextField
        textField.inputView = pickerView
        
        // Añadir una barra de herramientas con un botón "Hecho"
       let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Hecho", style: .done, target: self, action: #selector(cerrarPicker))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
    }

    
    @IBAction func guardar_registro(_ sender: Any) {
        Task { @MainActor in
            
            await guardar_registro_asincrono()
        }
    }
    
    func guardar_registro_asincrono() async{
        do {
            var data: [String: Any] = [
                "user": txtUser.text ?? "no has puesto usuario",
                "password": txtPassword.text ?? "no has puesto password"
            ]
            
            if (textField.text != "Otros") {
                data["plataforma"] = textField.text ?? "Otros"
            } else {
                data["plataforma"] = txtOtro.text ?? "no has puesto plataforma"
            }
            
            try await db.collection(userLogin).addDocument(data: data)
            
            print("Documento añadido exitosamente")
            mostrarAlerta()
            //borrar campos
            txtUser.text=nil
            txtPassword.text=nil
            textField.text=nil
        } catch {
            print("Error al añadir documento: \(error)")
        }

        
    }
    
    func mostrarAlerta() {
        // Crea la alerta
        let alerta = UIAlertController(title: "Info", message: "Registro guardado exitosamente", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Encuentra la escena activa
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            
            // Presenta la alerta desde el controlador raíz
            rootViewController.present(alerta, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Número de columnas
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return opciones.count // Número de filas
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return opciones[row] // Texto para cada fila
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = opciones[row] // Actualizar texto al seleccionar
        if(textField.text == "Otros"){
            txtOtro.isHidden=false

        }
        else{
            txtOtro.isHidden=true

        }
        cerrarPicker()
    }

    //Esta fun se activa al dar al boton de hecho
    @objc func cerrarPicker() {
        if(textField.text == "Otros"){
            txtOtro.isHidden=false

        }
        else{
            txtOtro.isHidden=true

        }
        view.endEditing(true) // Ocultar el picker
    }
    
   

}

