//
//  AppDelegate.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    // Create the SwiftUI view that provides the window contents.
    let contentView = ContentView()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillResignActive(_ notification: Notification) {
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    //windowを閉じたらDockに残さない
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        //データ保存
        contentView.user.save()
        return true
    }
}

