import UIKit

class InfoVC: UIViewController {
    
    fileprivate let sections = ["Информация", "Доп информация"]
    fileprivate let infoArray = [
        ["Инфо 1", "1"],
        ["Инфо 2", "2"],
        ["Инфо 3", "3"],
        ["Инфо 4", "4"]
    ]
    fileprivate let additionalInfoArray = [
        ["Доп инфо 1", "1"],
        ["Доп инфо 2", "a"],
        ["Доп инфо 3", "3"],
        ["Доп инфо 4", "c"],
        ["Доп Инфо 5", "f"]
    ]
    fileprivate var tableView = UITableView()
    fileprivate var cellIdentifier = "cell"
    var point = 0
    
    lazy var button: UIButton = {
        var button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Точка " + String(point)
        
        tableView = UITableView()
        tableView.backgroundColor = .clear
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        addSubViews(view: view)
        setupConstraints()
    }
        
    func addSubViews(view: UIView) {
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return sections.count }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { return sections[section] }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 60.0 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return infoArray.count }
        else if section == 1 { return additionalInfoArray.count }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
        
        if indexPath.section == 0 {
            cell.textLabel?.text = infoArray[indexPath.row][0]
            cell.detailTextLabel?.text = infoArray[indexPath.row][1]
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = additionalInfoArray[indexPath.row][0]
            cell.detailTextLabel?.text = additionalInfoArray[indexPath.row][1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        cell.selectedBackgroundView?.backgroundColor = .clear
        
        if cell.detailTextLabel?.text == "✓" && indexPath.section == 0 {
            cell.detailTextLabel?.text = infoArray[indexPath.row][1]
            cell.detailTextLabel?.textColor = .black
        } else if cell.detailTextLabel?.text == "✓" && indexPath.section == 1 {
            cell.detailTextLabel?.text = additionalInfoArray[indexPath.row][1]
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.detailTextLabel?.text = "✓"
            cell.detailTextLabel?.textColor = .blue
        }
    }
}


