//
//  mymenubarApp.swift
//  mymenubar
//
//  Created by Mason on 11/2/22.
//

import SwiftUI

@main
struct mymenubarApp: App {
    @State var scripts : [URL]
    
    var body: some Scene {
        MenuBarExtra("MMBA", systemImage: "hammer") {
            VStack {
                ForEach (scripts, id: \.self) { script_url in
                    Button("\(script_url.lastPathComponent)") {
                        do {
                            try Process.run(script_url, arguments: []) {_ in
                                
                            }
                        } catch {
                            
                        }
                    }
                }
            }
            Divider()
            Button("Refresh") {
                print("TODO")
            }
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
    
    init() {
        do {
            let documentURL = FileManager.default.homeDirectoryForCurrentUser
            let path = documentURL.appendingPathComponent(".config").appendingPathComponent("mmba").absoluteURL
            scripts = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: [])
        } catch {
            print(error.localizedDescription)
            scripts = []
        }
    }
}
