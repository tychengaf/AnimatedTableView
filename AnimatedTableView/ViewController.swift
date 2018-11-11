
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuView: UIViewX!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var tableData: [Model] = []
    var dayWeatherModel: DayWeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        Data.getData { (data) in
            self.tableData = data
            self.tableView.reloadData()
            self.animateTableCells()
        }
        
        Data.getDayWeather(completion: { (data) in
            if let data = data{
                self.dayLabel.text = data.dayName
                self.dateLabel.text = data.longDate
                self.cityLabel.text = data.city
                self.temperatureLabel.text = data.temperature
                self.weatherImageView.image = data.weatherIcon

            }
        })
        
        closeMenu()
        setupAnimatedControls()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.dayView.transform = .identity
            self.weatherView.transform = .identity
        })
    }
    func setupAnimatedControls(){
        dayView.transform = CGAffineTransform(translationX: -dayView.frame.width, y: 0)
        weatherView.transform = CGAffineTransform(translationX: weatherView.frame.width, y: 0)
    }
    @IBAction func menuTapped(_ sender: FloatingActionButton) {
        
        UIView.animate(withDuration:0.3, animations:{
            if self.menuView.transform == .identity {
                //opened, close it
                self.closeMenu()
            } else {
                //closed, open it
                self.menuView.transform = .identity
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity{
                self.pencilButton.transform = .identity
                self.alarmButton.transform = .identity
                self.messageButton.transform = .identity
            }
        })
    }
    
    func closeMenu() {
        menuView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        pencilButton.transform = CGAffineTransform(translationX: 0, y: 12)
        messageButton.transform = CGAffineTransform(translationX: 10, y: 10)
        alarmButton.transform = CGAffineTransform(translationX: 12, y: 0)
    }
    
    func animateTableCells(){
        let cells = tableView.visibleCells
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        }
        var delay = 0.3
        for cell in cells {
            UIView.animate(withDuration: 0.2, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {cell.transform = .identity})
            delay += 0.1
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tableData[indexPath.row]
        var cell : TableViewCell
        if model.images.count > 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellWithImages") as! TableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        }
        cell.setup(model: tableData[indexPath.row])
        return cell
      
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = tableData[indexPath.row]
        if model.images.count > 0 {
            return 100
        }
        
        return 70
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
