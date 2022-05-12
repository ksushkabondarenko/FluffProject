import UIKit
import CoreData

class EnterYourWeightViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainTextField: UITextField!
    // MARK: - Actions
    @IBAction func addButton(_ sender: Any) {
        if mainTextField.text != "" {
            let weightText = mainTextField.text
            if Double(mainTextField.text!) != nil {
                let weightNumber = Double(weightText!)
                let date = NSDate()
                let weight = WeightModel(weight: weightNumber!, date: date as Date)
                CoreDataManager.instance.saveWeight(weight)
            }  else {
                showAllert("Please, fill in the field only with numbers and a dot!")
            }
        } else {
            showAllert("Fill your weight!")
        }
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Private
    private var arrayWeights = [WeightModel]()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let weights = CoreDataManager.instance.getWeight() else {return}
        arrayWeights = weights
    }
    // MARK: - Helpers
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension EnterYourWeightViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ simpleTextField: UITextField) -> Bool {
        view.endEditing(true)
    }
}


