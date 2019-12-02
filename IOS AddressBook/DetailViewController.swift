import UIKit
import AddressBookCommon

class DetailViewController: UIViewController ,ContactDetailView {
    
    private var presenter: ContactDetailPresenter!
    var contactId: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthfayLabel: UILabel!
    @IBOutlet weak var phonesLabel: UILabel!
    @IBOutlet weak var addressesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CommonInjector.init().contactDetailPresenter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.attachView(view: self)
        presenter.getContact(contactId: contactId!)    
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.detachView()
    }
    
    func displayContact(contact: Contact) {
           nameLabel.text = contact.fullName

           let date = Date(timeIntervalSince1970: contact.birthday / 1000)
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           birthfayLabel.text = dateFormatter.string(from: date)

           for (index,phone) in contact.phones.enumerated() {
               phonesLabel.text! += phone.type.displayedName + ": "
                                   + phone.number

               if index < contact.phones.count-1 { phonesLabel.text! += "\n" }
           }

           for (index, address) in contact.addresses.enumerated() {
               addressesLabel.text! += address.type.displayedName + ":\n "
                               + address.street + "\n"
                               + address.postalCode + " " + address.city + "\n"
                               + address.country

               if index < contact.addresses.count - 1 {
                   addressesLabel.text! += "\n------------------------------\n"
               }
           }
       }
}
