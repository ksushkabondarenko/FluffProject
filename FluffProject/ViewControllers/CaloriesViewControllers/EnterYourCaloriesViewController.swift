import UIKit

class EnterYourCaloriesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var mainTextField: UITextField!
    // MARK: - Actions
    @IBAction func addButton(_ sender: Any) {
        if mainTextField.text != "" {
            let newCalories = Int(mainTextField.text!)
            UserDefaults.standard.set(newCalories, forKey: "valueFromCaloriesTextField")
            let ateCalories = UserDefaults.standard.integer(forKey: "valueFromAteCaloriesTextField") + newCalories!
            UserDefaults.standard.set(ateCalories, forKey: "valueFromAteCaloriesTextField")
        }  else {
            showAllert("Fill your calories!")
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
extension EnterYourCaloriesViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ simpleTextField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
