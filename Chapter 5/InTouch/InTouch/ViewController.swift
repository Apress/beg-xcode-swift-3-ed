//
//  ViewController.swift
//  InTouch
//
//  Created by Matthew Knott on 02/08/2014.
//  Copyright (c) 2014 Matthew Knott. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBAction func sendEmail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail()
        {
            var mailVC = MFMailComposeViewController()
            
            mailVC.setSubject("Beginning Xcode")
            mailVC.setToRecipients(["xcode@mattknott.com"])
            mailVC.setMessageBody("<p>I am really enjoying the book!</p>", isHTML: false)
            mailVC.mailComposeDelegate = self;
            
            self.presentViewController(mailVC, animated: true, completion: nil)
        }
        else
        {
            println("This device is currently unable to send email")
        }
    }
    @IBAction func sendText(sender: AnyObject) {
        if MFMessageComposeViewController.canSendText()
        {
            var smsVC : MFMessageComposeViewController = MFMessageComposeViewController()
            smsVC.messageComposeDelegate = self
            smsVC.recipients = ["1234500000"]
            smsVC.body = "I am interested in your products, please call me back."
            self.presentViewController(smsVC, animated: true, completion: nil)
        }
            else
        {
            println("This device is currently unable to send text messages")
        }
    }
    
    @IBAction func openWebsite(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://apress.com"))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
            case MFMailComposeResultSent.value:
                println("Result: Email Sent!")
            
            case MFMailComposeResultCancelled.value:
                println("Result: Email Cancelled.")
                
            case MFMailComposeResultFailed.value:
                println("Result: Error, Unable to Send Email.")
            
            case MFMailComposeResultSaved.value:
                println("Result: Mail Saved as Draft.")
            
            default:
                println("unknown");
        }

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        
        switch result.value {
        
        case MessageComposeResultSent.value:
                println("Result: Text Message Sent!")
        
        case MessageComposeResultCancelled.value:
                println("Result: Text Message Cancelled.")
        
        case MessageComposeResultFailed.value:
                println("Result: Error, Unable to Send Text Message.")
        default:
            println("unknown");
        
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

