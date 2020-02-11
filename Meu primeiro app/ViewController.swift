import UIKit
import os.log


class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var selecionador = UIImagePickerController();
    
    var alerta = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
    
    var currentVC : UIViewController?
    
    var bar: Bar?
    
    var viewController: UIViewController?
    
    var retornoSelecionador : ((UIImage) -> ())?;
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }

    
    
    @IBOutlet weak var RatingEstrela: RatiwgBar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nomeBar: UITextField!
    @IBOutlet weak var endereco:   UITextField!
    @IBOutlet weak var avaliacao: UITextField!
    @IBOutlet weak var telefone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeBar.delegate = self
        endereco.delegate = self
        avaliacao.delegate = self
        telefone.delegate = self
        longitude.delegate = self
        latitude.delegate = self
        
        if let bar = bar {
            navigationItem.title = bar.name
            nomeBar.text = bar.name
            imageView.image = bar.photo
            RatingEstrela.ratiwg = bar.rating
            telefone.text = bar.telefone
            longitude.text = bar.longitude
            latitude.text = bar.latitude
        
            
        }
        
        
        updateSaveButtonState()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo : String!
        switch textField {
        case nomeBar:
            nomeCampo = "Bar: "
            break;
        case endereco:
            nomeCampo = "Endereco: "
            break
        case telefone:
            nomeCampo = "Telefone: "
            break
        case avaliacao:
            nomeCampo = "Avaliacao: "
            break
        default:
            nomeCampo = "padrao: "
        }
        print(nomeCampo + textField.text!)
        return true;
    }
    
    @IBAction func cadastrar(_ sender: Any) {
        print(nomeBar.text!)
        print(endereco.text!)
        print(telefone.text!)
        print(avaliacao.text!)
        
    }
    
    
    
    //MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nomeBar.text ?? ""
        let photo = imageView.image
        let rating = RatingEstrela.ratiwg
        let telefone = self.telefone.text ?? ""
    
        
        bar = Bar(name: name, photo: photo, rating: rating, latitude: 1234, longitude: 4321,  telefone: telefone )
    }
    
    @IBAction func imagem(_ sender: Any) {
        showActionSheet(vc: self)
    }
    
    
    func galeria(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Esperava-se uma imagem, mas foi dado o seguinte: \(info)")
        }
        
        imageView.image = image
    }
    
    func camera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    func showActionSheet(vc: UIViewController) {
            currentVC = vc
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                self.camera()
            }))
            actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                self.galeria()
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            vc.present(actionSheet, animated: true, completion: nil)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
  
        updateSaveButtonState()
        navigationItem.title = nomeBar.text
    }
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nomeBar.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}
