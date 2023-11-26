//
//  VideoView.swift
//  Fitness Project
//
//  Created by Tran Phat on 10/21/23.
//

import SwiftUI
import WebKit

struct extractID: View {
//    let exercise: Exercise
    let youtubeURL = "https://www.youtube.com/watch?v=kkBB8afMliY&ab_channel=iKh4everStudio"
    @State var videoID:String = ""
    
    var body: some View {
        if let videoID = extractVideoID(from: youtubeURL) {
                 return Text("\(videoID)")
             } else {
                 return Text("Video ID not found in the URL.")
             }
         }
        
//        VideoViews(videoID:"oe7N2GUzHIw")
//            .ignoresSafeArea(edges: .all)
     
    
    func extractVideoID(from url: String) -> String? {
        if let range = url.range(of: "v=") {
            let startIndex = range.upperBound
            let endIndex = url.index(startIndex, offsetBy: 11) // Assuming the video ID is 11 characters
            return String(url[startIndex..<endIndex])
        }
        return nil
    
}
}

struct VideoViews: UIViewRepresentable {
    @Binding var exercise: todo
    @State var videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let ID = extractVideoID(from: videoID) ?? videoID
//        guard let imageURL = URL(string: "https://img.youtube.com/vi/\(ID)/1.jpg") else {return}
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(ID)") else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
    func extractVideoID(from url: String) -> String? {
        if let range = url.range(of: "v=") {
            let startIndex = range.upperBound
            let endIndex = url.index(startIndex, offsetBy: 11) // Assuming the video ID is 11 characters
            return String(url[startIndex..<endIndex])
        }
        return nil
    
}
}

struct VideoViews2: UIViewRepresentable {
    @Binding var exercise: Exercise2
    @State var videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let ID = extractVideoID(from: videoID) ?? videoID
//        guard let imageURL = URL(string: "https://img.youtube.com/vi/\(ID)/1.jpg") else {return}
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(ID)") else {return}
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
    func extractVideoID(from url: String) -> String? {
        if let range = url.range(of: "v=") {
            let startIndex = range.upperBound
            let endIndex = url.index(startIndex, offsetBy: 11) // Assuming the video ID is 11 characters
            return String(url[startIndex..<endIndex])
        }
        return nil
    
}
}



struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        // Implement any navigation delegate methods if needed
    }
}

struct VideoPlayerWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML = """
        <iframe width="100%" height="100%" src="\(url)" frameborder="0" allowfullscreen></iframe>
        """
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: VideoPlayerWebView
        
        init(_ parent: VideoPlayerWebView) {
            self.parent = parent
        }
        
        // Implement any navigation delegate methods if needed
    }
}


