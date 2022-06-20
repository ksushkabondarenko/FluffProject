import UIKit

class EnterYourGoalWeightViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainTextField: UITextField!
    // MARK: - Actions
    @IBAction func addButton(_ sender: Any) {
        if mainTextField.text != "" {
            let weightText = mainTextField.text
            if Double(mainTextField.text!) != nil {
                let weightNumber = Double(weightText!)
                UserDefaults.standard.set(weightNumber, forKey: "valueFromGoalTextField")
            }  else {
                showAllert("Please, fill in the field only with numbers and a dot!")
            }
        } else {
            showAllert("Fill your goal weight!")
        }
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension EnterYourGoalWeightViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ simpleTextField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
