import UIKit
import CoreData

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var mainStackView: UIStackView!
    // MARK: Private
    private let profileImage = UIImageView()
    private let scrollView = UIScrollView()
    private let infoView = UIView()
    private let nameLabel = UILabel()
    private let nameButtom = UIButton()
    private let heightLabel = UILabel()
    private let heightButton = UIButton()
    private let ratingLabel = UILabel()
    private let imageButton = UIButton()
    private var selectedImage: UIImage?
    private var imagePicker = UIImagePickerController()
    private var mainTableView = UITableView()
    private let nameOfCells = ["Daily caloric needs", "Calorie needs for weight loss", "Body mass index"]
    private var valueOfCells = [Any]()
    private var arrayWeights = [WeightModel]()
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTableView.reloadData()
        var dcn = (0.063 * (arrayWeights.last?.weight ?? 1.0) + 2.8957) * 240
        var cnfl = dcn * 0.8
        var heightFormyla = Double(UserDefaults.standard.string(forKey: "valueHeightTextField") ?? "100")
        var bmi = (arrayWeights.last?.weight ?? 1.0)/(heightFormyla! * heightFormyla!) * 1000
        valueOfCells = [dcn, cnfl, bmi]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        guard let weights = CoreDataManager.instance.getWeight() else {return}
        arrayWeights = weights
        addSubviews()
        addConstraints()
        setupUI()
    }
    // MARK: - Setups
    private func addSubviews() {
        view.addSubViews(scrollView)
        view.addSubViews(mainTableView)
        scrollView.addSubViews(profileImage, imageButton, infoView,nameLabel, nameButtom, heightLabel, heightButton)
    }
    private func addConstraints() {
        addScrollViewConstraint()
        addProfileImageConstraint()
        addImageButtonConstraint()
        addInfoViewConstraint()
        addNameLabelConstraint()
        addNameButtonConstraints()
        addHeightButtonConstraints()
        addHeightLabelConstraints()
        addMainTableViewConstraints()
    }
    private func addScrollViewConstraint() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    private func addProfileImageConstraint() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    private func addImageButtonConstraint() {
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    private func addInfoViewConstraint() {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 380).isActive = true
        infoView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        infoView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30).isActive = true
    }
    private func addNameLabelConstraint() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
    }
    private func addNameButtonConstraints() {
        nameButtom.translatesAutoresizingMaskIntoConstraints = false
        nameButtom.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -20).isActive = true
        nameButtom.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -20).isActive = true
        nameButtom.heightAnchor.constraint(equalTo: nameLabel.heightAnchor, constant: 20).isActive = true
        nameButtom.widthAnchor.constraint(equalTo: nameLabel.widthAnchor, constant: 20).isActive  = true
    }
    private func addMainTableViewConstraints() {
        //tableView
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: infoView.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor).isActive = true
    }
    private func addHeightButtonConstraints() {
        heightButton.translatesAutoresizingMaskIntoConstraints = false
        heightButton.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 20).isActive = true
        heightButton.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        heightButton.heightAnchor.constraint(equalTo: nameLabel.heightAnchor, constant: 20).isActive = true
        heightButton.widthAnchor.constraint(equalTo: nameLabel.widthAnchor, constant: 20).isActive  = true
    }
    private func addHeightLabelConstraints() {
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 20).isActive = true
        heightLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        heightLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor, constant: 30).isActive = true
        heightLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor, constant: 30).isActive  = true
    }
    // MARK: - Setups
    private func setupUI() {
        // navigationController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Profile"
        // view
        self.view.backgroundColor = .systemBackground
        // profileImage
        profileImage.image = UIImage(named: "NoneImage")
        profileImage.layer.cornerRadius = 90
        profileImage.layer.masksToBounds = true
        //scrollView
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1200)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        //imageButton
        imageButton.addTarget(self, action: #selector(getImageButton), for: .touchUpInside)
        //infoView
        infoView.backgroundColor = .systemGray5
        infoView.layer.cornerRadius = 30
        //nameLabel
        nameLabel.text = UserDefaults.standard.string(forKey: "valueNameTextField") ?? "-"
        nameLabel.font = .systemFont(ofSize: 38, weight: .semibold)
        //nameButton
        nameButtom.addTarget(self, action: #selector(saveNameButtonClick), for: .touchUpInside)
        //heightButton
        heightButton.addTarget(self, action: #selector(saveHeightButtonClick), for: .touchUpInside)
        //heightLabel
        heightLabel.text = "\(UserDefaults.standard.string(forKey: "valueHeightTextField") ?? "125 cm") cm"
        heightLabel.textAlignment = .center
        heightLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        // mainTableView
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    // MARK: - Actions
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    private func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            profileImage.image = image
            selectedImage = image
        }
    }
    @objc private func getImageButton(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @objc private func saveNameButtonClick() {
        print("click")
        let alert = UIAlertController(
            title: "Change Name",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField() { newTextField in
            newTextField.placeholder = "Please enter your Name"
        }
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
        let createAction = UIAlertAction(
            title: "Create",
            style: .default
        ) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            if textFields[0].text != "" {
                
                if let taskText = textFields[0].text {
                    UserDefaults.standard.set(taskText, forKey: "valueNameTextField")
                    self.nameLabel.text = UserDefaults.standard.string(forKey: "valueNameTextField") ?? "-"
                }
            }
        }
        alert.addAction(createAction)
        present(alert, animated: true, completion: nil)
    }
    @objc private func saveHeightButtonClick() {
        print("click")
        let alert = UIAlertController(
            title: "Change Height",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField() { newTextField in
            newTextField.placeholder = "Please enter your height"
        }
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
        let createAction = UIAlertAction(
            title: "Create",
            style: .default
        ) { [weak alert] _ in
            guard let textFields = alert?.textFields else { return }
            if textFields[0].text != "" {
                if let height = Int(textFields[0].text!) {
                    UserDefaults.standard.set(height, forKey: "valueHeightTextField")
                    self.heightLabel.text = "\(UserDefaults.standard.string(forKey: "valueHeightTextField") ?? "125") cm"
                }
            }
        }
        alert.addAction(createAction)
        present(alert, animated: true, completion: nil)
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameOfCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as? UITableViewCell {
            cell.textLabel?.text = self.nameOfCells[indexPath.row]
            cell.detailTextLabel?.text = self.valueOfCells[indexPath.row] as! String
            return cell
        }
        return UITableViewCell()
    }
}
