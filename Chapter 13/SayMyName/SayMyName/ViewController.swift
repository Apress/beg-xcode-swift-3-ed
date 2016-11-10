//
//  ViewController.swift
//  SayMyName
//
//  Created by Matthew Knott on 21/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import AddressBookUI

class ViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate {
    
    @IBOutlet weak var forenameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    
    
    
    @IBAction func getContact(sender: AnyObject) {
        if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Denied ||
            ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Restricted){
                println("Denied");
        }else if (ABAddressBookGetAuthorizationStatus() == ABAuthorizationStatus.Authorized){
            self.showPeoplePicker()
        } else { //Undetermined
            
            var emptyDictionary: CFDictionaryRef?
            var addressBook: ABAddressBookRef?
            
            println("requesting access...")
            addressBook = obtainAddressbook(ABAddressBookCreateWithOptions(emptyDictionary,nil))
            
            ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                if success {
                    println("success")
                    self.showPeoplePicker()
                }
                else
                {
                    println("error")
                }
            })
        }
    }
    @IBAction func sayContact(sender: AnyObject) {
        var personName = String(format: NSLocalizedString("SELECTED", comment: "Selected Person"), forenameField.text, surnameField.text)
        TextToSpeech.SayText(personName)
    }
    
    func showPeoplePicker() {
        
        var picker : ABPeoplePickerNavigationController = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        
        self.presentViewController(picker, animated: true, completion: nil)
    }

    func obtainAddressbook(addressbookRef: Unmanaged<ABAddressBookRef>!) -> ABAddressBookRef? {
        if let adressbook = addressbookRef {
            return Unmanaged<NSObject>.fromOpaque(adressbook.toOpaque()).takeUnretainedValue()
        }
        return nil
    }
    
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!,
        didSelectPerson person: ABRecordRef!) {
            
        if let forename = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as? NSString {
            forenameField.text = forename
        }
        
        if let surname = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as? NSString {
            surnameField.text = surname
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

