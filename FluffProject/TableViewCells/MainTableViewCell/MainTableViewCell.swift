import UIKit
final class SecondVCTableViewCell: UITableViewCell {
    // MARK: Private
    private var dateTitle: UILabel = UILabel()
    private var weightTitle: UILabel = UILabel()
    private let mainView: UIView = UIView()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addAllSubviews()
        addConstraints()
        addSetupsUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - API
    func set(weight: WeightModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let convertedDate = dateFormatter.string(from: weight.date)
        dateTitle.text = convertedDate
        weightTitle.text = String(round(weight.weight * 10)/10)
    }
    // MARK: Private
    private func addAllSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(dateTitle)
        mainView.addSubview(weightTitle)
    }
    // MARK: Private
    private func addConstraints() {
        addMainViewConstraint()
        addDateTitleConstraint()
        addWeightTitleConstraint()
    }
    private func addSetupsUI() {
        addCellSetUp()
        addDateTitleSetUp()
        addMainViewSetUp()
        addWeightTitleSetUp()
    }
    private func addMainViewConstraint() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    private func addDateTitleConstraint() {
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        dateTitle.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20).isActive = true
        dateTitle.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    private func addWeightTitleConstraint() {
        weightTitle.translatesAutoresizingMaskIntoConstraints = false
        weightTitle.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        weightTitle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -25).isActive = true
        weightTitle.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private func addMainViewSetUp() {
        mainView.layer.cornerRadius = 13
        mainView.backgroundColor = .systemGray4
    }
    private func addCellSetUp() {
        self.selectionStyle = .none
        //self.backgroundColor = AppColor.backgroundColor
    }
    private func addDateTitleSetUp() {
        dateTitle.numberOfLines = 0
        dateTitle.textColor = .black
    }
    private func addWeightTitleSetUp() {
        weightTitle.numberOfLines = 0
        weightTitle.textColor = .systemGray
        weightTitle.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
}
