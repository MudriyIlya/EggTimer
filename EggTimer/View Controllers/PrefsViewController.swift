//
//  PrefsViewController.swift
//  EggTimer
//
//  Created by Ilya Mudriy on 09/03/2019.
//  Copyright © 2019 Ilya Mudriy. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {

    @IBOutlet weak var presetsPopup: NSPopUpButton!
    @IBOutlet weak var customSlider: NSSlider!
    @IBOutlet weak var customTextField: NSTextField!
    
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        showExistingPrefs()
    }
    
    func showExistingPrefs() {
        let selectedTimeInMinutes = Int(prefs.selectedTime) / 60
        
        presetsPopup.selectItem(withTitle: "Custom")
        customSlider.isEnabled = true
        
        for item in presetsPopup.itemArray {
            if item.tag == selectedTimeInMinutes {
                presetsPopup.select(item)
                customSlider.isEnabled = false
                break
            }
        }
        
        customSlider.integerValue = selectedTimeInMinutes
        showSliderValuesAsText()
    }
    func showSliderValuesAsText() {
        let newTimerDuration = customSlider.integerValue
        let minutesDescription = (newTimerDuration == 1) ? "minute" : "minutes"
        customTextField.stringValue = "\(newTimerDuration) \(minutesDescription)"
    }
    
    func saveNewPrefs() {
        prefs.selectedTime = customSlider.doubleValue * 60
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PrefsChanged"),
                                        object: nil)
    }
    
    @IBAction func popupValueChanged(_ sender: NSPopUpButton) {
        if sender.selectedItem?.title == "Custom" {
            customSlider.isEnabled = true
            return
        }
        
        let newTimeDuration = sender.selectedTag()
        customSlider.integerValue = newTimeDuration
        showSliderValuesAsText()
        customSlider.isEnabled = false
    }
    @IBAction func sliderValueChanged(_ sender: NSSlider) {
        showSliderValuesAsText()
    }
    @IBAction func okButtonClicked(_ sender: Any) {
        saveNewPrefs()
        view.window?.close()
    }
    @IBAction func cancelButtonClicked(_ sender: Any) {
        view.window?.close()
    }
}
