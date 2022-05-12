import UIKit

class CaloriesViewController: UIViewController {
    // MARK: - Private
    private let mainView: UIView = UIView()
    private let circleView: UIView = UIView()
    private let caloriesLabel: UILabel = UILabel()
    private let caloriesTextLabel: UILabel = UILabel()
    private let plusButton: UIButton = UIButton()
    private var ateCalories: Int = 0
    private let goalWeightCircleView: UIView = UIView()
    private let plusGoalButton: UIButton = UIButton()
    private let startWeightCircleView: UIView = UIView()
    private let startWeightLabel: UILabel = UILabel()
    private let startWeightTextLabel: UILabel = UILabel()
    private let plusStartButton: UIButton = UIButton()
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let newCalories = UserDefaults.standard.integer(forKey: "valueFromCaloriesTextField")
        let limitCalories = UserDefaults.standard.integer(forKey: "valueFromCaloriesLimitTextField")
        startWeightLabel.text = String(limitCalories)
        //UserDefaults.standard.set(ateCalories, forKey: "valueFromAteCaloriesTextField")
        ateCalories = UserDefaults.standard.integer(forKey: "valueFromAteCaloriesTextField")
        UserDefaults.standard.set(ateCalories, forKey: "valueFromAteCaloriesTextField")
        circleView.backgroundColor = .gray
        caloriesLabel.text = String(ateCalories)
        if ateCalories >= limitCalories {
            circleView.backgroundColor = .red
        } else {
            circleView.backgroundColor = .green
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        addConstraints()
    }
    // MARK: - Setups
    private func addSubviews() {
        view.addSubViews(mainView, circleView, caloriesLabel, caloriesTextLabel, plusButton, goalWeightCircleView, plusGoalButton, startWeightCircleView, startWeightLabel, startWeightTextLabel, plusStartButton)
    }
    private func setupUI() {
        //circleView
        circleView.backgroundColor = .systemGray5
        circleView.layer.cornerRadius = 150
        //caloriesLabel
        caloriesLabel.text = "-"
        caloriesLabel.font = .systemFont(ofSize: 64, weight: .bold)
        caloriesLabel.textColor = .white
        //caloriesTextLabel
        caloriesTextLabel.text = "CALORIES"
        caloriesTextLabel.font = .systemFont(ofSize: 16, weight: .regular)
        caloriesTextLabel.textColor = .systemGray
        //plusButton
        plusButton.titleLabel?.font = .systemFont(ofSize: 38, weight: .bold)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.gray, for: .normal)
        plusButton.addTarget(self, action: #selector(saveButtonClick), for: .touchUpInside)
        // navigationController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Weight Control"
        // view
        self.view.backgroundColor = .systemBackground
        //goalWeightCircleView
        goalWeightCircleView.layer.cornerRadius = 60
        goalWeightCircleView.backgroundColor = .gray
        //plusGoalButton
        plusGoalButton.titleLabel?.font = .systemFont(ofSize: 38, weight: .regular)
        plusGoalButton.setTitle("Reset", for: .normal)
        plusGoalButton.setTitleColor(.white, for: .normal)
        plusGoalButton.addTarget(self, action: #selector(saveGoalButtonClick), for: .touchUpInside)
        //startWeightCircleView
        startWeightCircleView.layer.cornerRadius = 60
        startWeightCircleView.backgroundColor = .gray
        //startWeightLabel
        startWeightLabel.text = "-"
        startWeightLabel.font = .systemFont(ofSize: 36, weight: .bold)
        startWeightLabel.textColor = .white
        //startWeightTextLabel
        startWeightTextLabel.text = "LIMIT"
        startWeightTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
        startWeightTextLabel.textColor = .white
        //plusStartButton
        plusStartButton.titleLabel?.font = .systemFont(ofSize: 38, weight: .regular)
        plusStartButton.setTitle("", for: .normal)
        plusStartButton.setTitleColor(.white, for: .normal)
        plusStartButton.addTarget(self, action: #selector(saveStartButtonClick), for: .touchUpInside)
    }
    private func addConstraints() {
        addMainViewConstraint()
        addCircleViewConstraint()
        addCaloriesLabelConstraint()
        addCaloriesTextLabelConstraint()
        addPlusButtonConstraint()
        addGoalWeightCircleViewConstraint()
        addPlusGoalButtonConstraint()
        addStartWeightLabelConstraint()
        addStartWeightTextLabelConstraint()
        addPlusStartButtonConstraint()
        addWeightCircleViewConstraint()
    }
    private func addMainViewConstraint() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
    }
    private func addCircleViewConstraint() {
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    private func addCaloriesLabelConstraint() {
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        caloriesLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: -15).isActive = true
    }
    private func addCaloriesTextLabelConstraint() {
        caloriesTextLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesTextLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        caloriesTextLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: 35).isActive = true
    }
    private func addPlusButtonConstraint() {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: 65).isActive = true
    }
    private func addGoalWeightCircleViewConstraint() {
        goalWeightCircleView.translatesAutoresizingMaskIntoConstraints = false
        goalWeightCircleView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        goalWeightCircleView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 170).isActive = true
        goalWeightCircleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        goalWeightCircleView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    private func addPlusGoalButtonConstraint() {
        plusGoalButton.translatesAutoresizingMaskIntoConstraints = false
        plusGoalButton.centerXAnchor.constraint(equalTo: goalWeightCircleView.centerXAnchor).isActive = true
        plusGoalButton.centerYAnchor.constraint(equalTo: goalWeightCircleView.centerYAnchor).isActive = true
    }
    private func addWeightCircleViewConstraint() {
        startWeightCircleView.translatesAutoresizingMaskIntoConstraints = false
        startWeightCircleView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        startWeightCircleView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -170).isActive = true
        startWeightCircleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        startWeightCircleView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    private func addStartWeightLabelConstraint() {
        startWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        startWeightLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        startWeightLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: -180).isActive = true
    }
    private func addStartWeightTextLabelConstraint() {
        startWeightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        startWeightTextLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        startWeightTextLabel.centerYAnchor.constraint(equalTo: startWeightLabel.centerYAnchor, constant: 33).isActive = true
    }
    private func addPlusStartButtonConstraint() {
        plusStartButton.translatesAutoresizingMaskIntoConstraints = false
        plusStartButton.leadingAnchor.constraint(equalTo: startWeightCircleView.leadingAnchor).isActive = true
        plusStartButton.trailingAnchor.constraint(equalTo: startWeightCircleView.trailingAnchor).isActive = true
        plusStartButton.topAnchor.constraint(equalTo: startWeightCircleView.topAnchor).isActive = true
        plusStartButton.bottomAnchor.constraint(equalTo: startWeightCircleView.bottomAnchor).isActive = true
    }
    // MARK: - Actions
    @objc private func saveButtonClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EnterYourCaloriesViewController") as! EnterYourCaloriesViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func saveGoalButtonClick() {
        ateCalories = 0
        caloriesLabel.text = "\(ateCalories)"
        UserDefaults.standard.set(ateCalories, forKey: "valueFromAteCaloriesTextField")
    }
    @objc private func saveStartButtonClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc4 = storyboard.instantiateViewController(withIdentifier: "EnterYourLimitCaloriesViewController") as! EnterYourLimitCaloriesViewController
        navigationController?.pushViewController(vc4, animated: true)
    }
}


