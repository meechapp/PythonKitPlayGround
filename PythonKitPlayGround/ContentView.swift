//
//  ContentView.swift
//  PythonKitPlayGround
//
//  Created by Demetrius Sidyakin on 10/20/20.
//

import SwiftUI
import PythonKit
import AVKit

struct VideoView: View {
    
    @State private var txt : String = ""
    @State private var videoPath : String? = ""
    
    var dirPath : String
    
    var body: some View {
 
    
        VStack{
            TextField("Enter the video link", text: $txt)
            
            Button(action: {
                self.downloadVideo(link: self.txt)
            }, label: {
                Text("Download Video")
            })
            
            //for iOS 14 and macOS 11+
            if let videoPath = videoPath{
                
                let url = URL(fileURLWithPath:dirPath+videoPath)
//                VideoPlayer(player: AVPlayer(url: url))
                
               
            }
            
            
        }
    }
    
    func downloadVideo(link: String){
        let sys = Python.import("sys")
        sys.path.append(dirPath)
        let example = Python.import("video")
        let response = example.downloadVideo(link, dirPath)
        videoPath = String(response)
    }
}

struct ContentView: View {
    
    @State var result: String = ""
    @State var swapA : Int = 2
    @State var swapB : Int = 3
    var dirPath = "/Users/meech/documents/developer/Python/ForPythonKitPlayground"
    
    var body: some View {
        HStack {
            VStack {
                Button("Run Python Script") {
                    runPythonCode()
                }
                Text("\(result)")
            }
            VStack {
                Button("Swap Numbers") {
                    swapNumbersInPython()
                }
                HStack {
                    Text("\(swapA)")
                    Text("\(swapB)")
                }
            }
            VideoView(dirPath: dirPath)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func runPythonCode(){
      let sys = Python.import("sys")
        sys.path.append(dirPath)
      let example = Python.import("main")
      let response = example.hello()
        result = response.description
    }
    
    func swapNumbersInPython() {
        let sys = Python.import("sys")
        sys.path.append(dirPath)
        let example = Python.import("main")
        let response = example.swap(swapA, swapB)
        let a : [Int] = Array(response)!
        swapA = a[0]
        swapB = a[1]
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
