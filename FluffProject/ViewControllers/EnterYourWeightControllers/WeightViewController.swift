import UIKit

class WeightViewController: UIViewController {
    // MARK: - Private
    private let mainView: UIView = UIView()
    private let circleView: UIView = UIView()
    private let currentWeightLabel: UILabel = UILabel()
    private let currentWeightTextLabel: UILabel = UILabel()
    private let startWeightCircleView: UIView = UIView()
    private let startWeightLabel: UILabel = UILabel()
    private let startWeightTextLabel: UILabel = UILabel()
    private let goalWeightCircleView: UIView = UIView()
    private let goalWeightLabel: UILabel = UILabel()
    private let goalWeightTextLabel: UILabel = UILabel()
    private let plusButton: UIButton = UIButton()
    private let plusStartButton: UIButton = UIButton()
    private let plusGoalButton: UIButton = UIButton()
    private var arrayWeights = [WeightModel]()
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let weights = CoreDataManager.instance.getWeight() else {return}
        arrayWeights = weights
        let curentWeight = String(round((arrayWeights.last?.weight ?? 0) * 10)/10)
        currentWeightLabel.text = curentWeight
        let goalWeight = String(round(UserDefaults.standard.double(forKey: "valueFromGoalTextField") * 10)/10)
        goalWeightLabel.text = goalWeight
        let startWeight = String(round(UserDefaults.standard.double(forKey: "valueFromStartTextField") * 10)/10)
        startWeightLabel.text = startWeight
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        addConstraints()
    }
    // MARK: - Setups
    private func addSubviews() {
        view.addSubViews(mainView, circleView, currentWeightLabel, currentWeightTextLabel, plusButton, startWeightCircleView, startWeightLabel, startWeightTextLabel, plusStartButton, goalWeightCircleView, goalWeightLabel, goalWeightTextLabel, plusGoalButton)
    }
    private func setupUI() {
        //mainView
        addMainViewSetUp()
        //circleView
        circleView.backgroundColor = .systemGray5
        circleView.layer.cornerRadius = 100
        //currentWeightLabel
        currentWeightLabel.text = "-"
        currentWeightLabel.font = .systemFont(ofSize: 64, weight: .bold)
        currentWeightLabel.textColor = .white
        //currentWeightTextLabel
        currentWeightTextLabel.text = "CURRENT WEIGHT"
        currentWeightTextLabel.font = .systemFont(ofSize: 16, weight: .regular)
        currentWeightTextLabel.textColor = .systemGray
        //startWeightCircleView
        startWeightCircleView.layer.cornerRadius = 60
        startWeightCircleView.backgroundColor = .gray
        //plusButton
        plusButton.titleLabel?.font = .systemFont(ofSize: 38, weight: .bold)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.gray, for: .normal)
        plusButton.addTarget(self, action: #selector(saveButtonClick), for: .touchUpInside)
        //startWeightLabel
        startWeightLabel.text = "-"
        startWeightLabel.font = .systemFont(ofSize: 42, weight: .bold)
        startWeightLabel.textColor = .white
        //startWeightTextLabel
        startWeightTextLabel.text = "START"
        startWeightTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
        startWeightTextLabel.textColor = .white
        //plusStartButton
        plusStartButton.titleLabel?.font = .systemFont(ofSize: 38, weight: .regular)
        plusStartButton.setTitle("+", for: .normal)
        plusStartButton.setTitleColor(.white, for: .normal)
        plusStartButton.addTarget(self, action: #selector(saveStartButtonClick), for: .touchUpInside)
        //goalWeightCircleView
        goalWeightCircleView.layer.cornerRadius = 60
        goalWeightCircleView.backgroundColor = .gray
        //goalWeightLabel
        goalWeightLabel.text = "-"
        goalWeightLabel.font = .systemFont(ofSize: 42, weight: .bold)
        goalWeightLabel.textColor = .white
        //goalWeightTextLabel
        goalWeightTextLabel.text = "GOAL"
        goalWeightTextLabel.font = .systemFont(ofSize: 14, weight: .regular)
        goalWeightTextLabel.textColor = .white
        //plusGoalButton
        plusGoalButton.titleLabel?.font = .systemFont(ofSize: 38, weight: .regular)
        plusGoalButton.setTitle("+", for: .normal)
        plusGoalButton.setTitleColor(.white, for: .normal)
        plusGoalButton.addTarget(self, action: #selector(saveGoalButtonClick), for: .touchUpInside)
        // navigationController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Weight Control"
        // view
        self.view.backgroundColor = .systemBackground
        //weight
        // weight.date = Date()
    }
    private func addConstraints() {
        addMainViewConstraint()
        addCircleViewConstraint()
        addCurrentWeightLabelConstraint()
        addCurrentWeightTextLabelConstraint()
        addWeightCircleViewConstraint()
        addPlusButtonConstraint()
        addStartWeightLabelConstraint()
        addStartWeightTextLabelConstraint()
        addGoalWeightCircleViewConstraint()
        addGoalWeightLabelConstraint()
        addGoalWeightTextLabelConstraint()
        addPlusStartButtonConstraint()
        addPlusGoalButtonConstraint()
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
        circleView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    private func addCurrentWeightLabelConstraint() {
        currentWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeightLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        currentWeightLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: -15).isActive = true
    }
    private func addCurrentWeightTextLabelConstraint() {
        currentWeightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeightTextLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        currentWeightTextLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: 35).isActive = true
    }
    private func addWeightCircleViewConstraint() {
        startWeightCircleView.translatesAutoresizingMaskIntoConstraints = false
        startWeightCircleView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        startWeightCircleView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -170).isActive = true
        startWeightCircleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        startWeightCircleView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    private func addPlusButtonConstraint() {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: 65).isActive = true
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
    private func addGoalWeightCircleViewConstraint() {
        goalWeightCircleView.translatesAutoresizingMaskIntoConstraints = false
        goalWeightCircleView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        goalWeightCircleView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 170).isActive = true
        goalWeightCircleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        goalWeightCircleView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    private func addGoalWeightLabelConstraint() {
        goalWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        goalWeightLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        goalWeightLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor, constant: 160).isActive = true
    }
    private func addGoalWeightTextLabelConstraint() {
        goalWeightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        goalWeightTextLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        goalWeightTextLabel.centerYAnchor.constraint(equalTo: goalWeightLabel.centerYAnchor, constant: 33).isActive = true
    }
    private func addPlusStartButtonConstraint() {
        plusStartButton.translatesAutoresizingMaskIntoConstraints = false
        plusStartButton.leadingAnchor.constraint(equalTo: startWeightCircleView.trailingAnchor, constant: 5).isActive = true
        plusStartButton.centerYAnchor.constraint(equalTo: startWeightCircleView.centerYAnchor).isActive = true
    }
    private func addPlusGoalButtonConstraint() {
        plusGoalButton.translatesAutoresizingMaskIntoConstraints = false
        plusGoalButton.leadingAnchor.constraint(equalTo: goalWeightCircleView.trailingAnchor, constant: 5).isActive = true
        plusGoalButton.centerYAnchor.constraint(equalTo: goalWeightCircleView.centerYAnchor).isActive = true
    }
    private func addMainViewSetUp() {
        mainView.layer.cornerRadius = 30
        mainView.backgroundColor = .systemGray3
    }
    // MARK: - Actions
    @objc private func saveButtonClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EnterYourWeightViewController") as! EnterYourWeightViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func saveGoalButtonClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "EnterYourGoalWeightViewController") as! EnterYourGoalWeightViewController
        navigationController?.pushViewController(vc2, animated: true)
    }
    @objc private func saveStartButtonClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc3 = storyboard.instantiateViewController(withIdentifier: "EnterYourStartWeightViewController") as! EnterYourStartWeightViewController
        navigationController?.pushViewController(vc3, animated: true)
    }
}
