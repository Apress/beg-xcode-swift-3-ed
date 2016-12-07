//
//  ViewController.swift
//  InTouch
//
//  Created by Matthew Knott on 17/07/2016.
//  Copyright © 2016 Matthew Knott. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBAction func sendEmail(_ sender: AnyObject) {
        if MFMailComposeViewController.canSendMail()
        {
            let mailVC = MFMailComposeViewController()
            
            mailVC.setSubject("Beginning Xcode")
            mailVC.setToRecipients(["xcode@mattknott.com"])
            mailVC.setMessageBody("<p>I am really enjoying the book!</p>", isHTML: false)
            mailVC.mailComposeDelegate = self;
            
            self.present(mailVC, animated: true, completion: nil)
        }
        else
        {
            print("This device is currently unable to send email")
        }
    }
    @IBAction func sendText(_ sender: AnyObject) {
        if MFMessageComposeViewController.canSendText()
        {
            let smsVC : MFMessageComposeViewController = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            smsVC.recipients = ["1234500000"]
            smsVC.body = "I am interested in your products, please call me back."
            self.present(smsVC, animated: true, completion: nil)
        }
        else
        {
            print("This device is currently unable to send text messages")
        }

    }
    @IBAction func openWebsite(_ sender: AnyObject) {
        UIApplication.shared.open(URL(string: "http://apress.com")!, options: [:], completionHandler: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result {
            
        case MessageComposeResult.sent:
            print("Result: Text Message Sent!")
            
        case MessageComposeResult.cancelled:
            print("Result: Text Message Cancelled.")
            
        case MessageComposeResult.failed:
            print("Result: Error, Unable to Send Text Message.")
        }
        
        self.dismiss(animated:true, completion: nil)
    }
    
    func mailComposeController(_ didFinishWithcontroller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            
        case MFMailComposeResult.sent:
            print("Result: Email Sent!")
            
        case MFMailComposeResult.cancelled:
            print("Result: Email Cancelled.")
            
        case MFMailComposeResult.failed:
            print("Result: Error, Unable to Send Email.")
            
        case MFMailComposeResult.saved:
            print("Result: Mail Saved as Draft.")
        }
        
        self.dismiss(animated: true, completion: nil)
    }



}

