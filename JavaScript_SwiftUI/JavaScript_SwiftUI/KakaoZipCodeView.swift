//
//  KakaoZipCodeView.swift
//  JavaScript_SwiftUI
//
//  Created by woosub kim  on 1/8/24.
//

import SwiftUI
import WebKit

// UIViewRepresentable 프로토콜을 채택하여 SwiftUI에서 UIView를 사용할 수 있게 합니다.
struct KakaoZipCodeView: UIViewRepresentable {
    // SwiftUI 뷰와 바인딩된 주소 데이터
    @Binding var address: String
    // SwiftUI 환경 변수를 사용하여 모달 뷰를 닫을 수 있습니다.
    @Environment(\.presentationMode) var presentationMode
    
    // SwiftUI가 UIView를 생성할 때 호출하는 메서드
    func makeUIView(context: Context) -> WKWebView {
        // WKWebView의 사용자 스크립트와 컨텐츠 컨트롤러를 설정합니다.
        // WKUserContentController = 자바스크립트 코드와 웹 보기 간의 상호작용을 관리하고 WebView의 콘텐츠를 필터링하기 위한 객체이다.
        let contentController = WKUserContentController()
        // JavaScript 메시지를 받기 위한 핸들러 설정
        contentController.add(context.coordinator, name: "callBackHandler")

        // WKWebView에 사용할 설정을 생성합니다.
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        // WKWebView 인스턴스를 생성하고 설정합니다.
        let webView = WKWebView(frame: .zero, configuration: configuration)
        // WKWebView의 네비게이션 대리자(delegate)를 설정합니다.
        webView.navigationDelegate = context.coordinator

        // 웹 페이지를 로드합니다. 여기서는 예시로 네이버 웹페이지를 로드하고 있습니다.
        if let url = URL(string: "https://woobios97.github.io/KakoPostcode/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }

        return webView
    }
    
    // SwiftUI가 UIView를 업데이트할 때 호출하는 메서드
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // Coordinator 클래스를 생성합니다. Coordinator는 WKNavigationDelegate와 WKScriptMessageHandler를 구현합니다.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

}

extension KakaoZipCodeView {
    // Coordinator 클래스는 WKWebView와의 상호작용을 처리한다,
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        
        // 부모 뷰에 대한 참조
        var parent: KakaoZipCodeView
        
        init(_ parent: KakaoZipCodeView) {
            self.parent = parent
        }
        
        // JavaScript로부터 메시지를 받았을 때 호출되는 메서드
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            // JavaScript 메시지에서 주소 데이터를 추출한다.
            if let data = message.body as? [String: Any], let roadAddress = data["roadAddress"] as? String {
                DispatchQueue.main.async {
                    // 주소 데이터를 SwiftUI 뷰의 상태를 업데이트하고 모달을 닫는다.
                    self.parent.address = roadAddress
                    self.parent.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

