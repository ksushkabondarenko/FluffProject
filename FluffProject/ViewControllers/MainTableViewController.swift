import UIKit

class MainTableViewController: UIViewController {
    // MARK: Private
    private var mainTableView = UITableView()
    private var arrayWeights = [WeightModel](){
        didSet {
            mainTableView.reloadData()
        }
    }
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //mainTableView.reloadData()
        guard let weights = CoreDataManager.instance.getWeight() else {return}
        arrayWeights = weights
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setupUI()
    }
    // MARK: - Setups
    private func addSubviews() {
        view.addSubViews(mainTableView)
    }
    private func setupUI() {
        // navigationController
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Daily Reports"
        // view
        self.view.backgroundColor = .systemBackground
        // mainTableView
        mainTableView.register(SecondVCTableViewCell.self, forCellReuseIdentifier: "SecondVCTableViewCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
    }
    private func addConstraints() {
        addMainTableViewConstraints()
    }
    private func addMainTableViewConstraints() {
        //tableView
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
extension MainTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeights.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondVCTableViewCell", for: indexPath) as? SecondVCTableViewCell {
            cell.set(weight: arrayWeights[indexPath.row])
            //.reversed()
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.instance.removeWeight(indexPath.row)
            arrayWeights.remove(at: indexPath.row)
        }
    }
    
}
