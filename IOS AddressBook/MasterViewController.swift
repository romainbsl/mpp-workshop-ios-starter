import UIKit
import AddressBookCommon

class MasterViewController: UITableViewController , ContactListView{
    
    private var contactList = [Contact]()
    private var presenter: ContactListPresenter!
    var detailViewController: DetailViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CommonInjector.init().contactListPresenter()
    }

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       presenter.attachView(view: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       presenter.detachView()
    }
    
    func displayContactList(contactList: [Contact]) {
       self.contactList = contactList
       self.tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = contactList[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.contactId = contact.id
            }
        }
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return contactList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       let contact = contactList[indexPath.row]
       cell.textLabel!.text = contact.fullName
       return cell
    }
}

