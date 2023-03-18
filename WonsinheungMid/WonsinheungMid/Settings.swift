//
//  Settings.swift
//  YourSchool
//
//  Created by 임준협 on 2023/03/01.
//

import SwiftUI
import Alamofire
import OctoKit
struct SettingsView: View {
    
    @AppStorage("alwaysLight") var alwaysLight = false

    @Binding var isFirstLaunching: Bool
    @Binding var userName: String
    @Binding var goReset: Bool
    @AppStorage("rainBar") var rainBar: Bool = true
    @Binding var rnum: Int
    var num = Int.random(in: 0...5)
    @Binding var colors: [Color]
    @State var showInfo = false
    @State var showBugRep = false
    var body: some View {
        VStack{
            Form {
//                Section{
                    
//                }
                Section(header: HStack{
                    Image(systemName: "graduationcap.circle")
                    Text("WonsinheungMid version \(version)")
                }) {
                    Button(action: {LightMode()}, label: {
                        HStack{
                            Image(systemName: "lightbulb")
                            Text("Always Light Mode \(LightModeStat())")
                        }
                    })
                    
                    Button(action: {cBar()}, label: {
                        HStack{
                            Image(systemName: "\(cBarStat()[0])")
                            Text("RainBar \(cBarStat()[1])")
                        }
                    })
                    
                    Button(action: {showInfo = true}, label: {
                        HStack{
                            Image(systemName: "info")
                            Text("  이 앱에 대하여")
                        }
                    })
                }
                Section {
                    Button(action: {showBugRep = true}, label: {
                        HStack{
                            Image(systemName: "ladybug")
                            Text("  버그 제보")
                        }
                    })
                }
                Section{
                    Button(action: {isFirstLaunching = true;userName = "";goReset = false}, label: {
                        HStack{
                            Image(systemName: "gear.badge.xmark")
                            Text("  초기화")
                        }
                        .foregroundColor(.red)
                    })
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            infoView()
        }
        .sheet(isPresented: $showBugRep) {
            bugReportView(showBugRep: $showBugRep)
        }
    }
    func cBar() {
        rainBar.toggle()
        print(rainBar)
        if rainBar {
            rnum = num
        } else {
            rnum = 0
        }
    }
    func cBarStat() -> [String] {
        var cStat: [String] = []
        if rainBar {
            cStat.append("light.min")

            cStat.append("비활성화")
        } else {
            cStat.append("light.max")

            cStat.append("활성화")
        }
        return cStat
    }
    func LightMode() {
        withAnimation{
            alwaysLight.toggle()
        }
        print(alwaysLight)
    }
    func LightModeStat() -> String {
        var lStat: String = ""
        if alwaysLight {
            lStat = ("비활성화")
        } else {
            lStat = ("활성화")
        }
        return lStat
    }
}
struct infoView: View {
    @State var viewLoaded = false
    @State var secondViewLoaded = false
    let height = UIScreen.main.bounds.height
    var body: some View{
        VStack{
            
                if viewLoaded{
                    Spacer()
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                    Text("원신흥중학교")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5).delay(0.5)))
                    Spacer()
                        


                    //                    Text("⠼")
                    //                        .font(.custom("AppleSymbols", size: 36))
                    
                    
                }
            if secondViewLoaded {
                
                    HStack{
                        Text("이 앱은")
                        Link("Jonathan0827", destination: URL(string: "https://github.com/Jonathan0827")!)
                        Text("이 제작한 앱입니다")
                    }
                    
                    .font(.title3)
                    
                
                .ignoresSafeArea()
                .frame(height: height*2/5)

                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
//                Spacer()
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                withAnimation { viewLoaded.toggle() }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation { secondViewLoaded.toggle() }
            })
        }
    }
}
struct bugReportView: View {
    @Binding var showBugRep: Bool
    @State var viewLoaded = false
    @State var secondViewLoaded = false
    @State var bugTitle: String = ""
    @State var bugDescription: String = ""
    @State var mailAddress: String = ""
    @State var fillFormWarning = false
    @State var bugReportInfo = []
    @State var issueNotSub: Bool = true
    @State var issueLoading: Bool = false
    @State var issueSub: Bool = false
    let placeholder = "Placeholder"

    let height = UIScreen.main.bounds.height
    var body: some View{
        VStack{
            
                if viewLoaded{
                    Spacer()
                    Image(systemName: "ladybug")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding(.top, 30)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                    Text("버그 제보")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5).delay(0.5)))
                    Spacer()
                        


                    //                    Text("⠼")
                    //                        .font(.custom("AppleSymbols", size: 36))
                    
                    
                }
            if secondViewLoaded {
//                ProgressView()
//                    .tint(.primary)
                Form {
                    Section() {
                        TextField("제목", text: $bugTitle)
                        
                    }
                    Section("버그를 설명해주세요.") {
                        TextEditor(text: $bugDescription)
                            .frame(height: height/5)
                    }
                }
                    
                    
                    //                    if bugWay.isEmpty {
                    //                        Text("버그를 재현하는 방법을 설명해주세요")
                    //                            .foregroundColor(Color(red: 0.773, green: 0.773, blue: 0.78))
                    //                                .zIndex(10)
                    //                                .font(.custom("Helvetica", size: 24))
                    //
                    //                                .padding(.all)
                    //                    }
                    Spacer()
                    if issueNotSub {
                        Button(action: {
                            if bugTitle.isEmpty{
                                fillFormWarning = true
                            } else if bugDescription.isEmpty {
                                fillFormWarning = true
                            } else {
                                issueNotSub = false
                                issueLoading = true
                                //                            generateIssue(title: bugTitleBlankToNbsp, description: bugDescriptionBlankToNbsp)
                                let config = TokenConfiguration(Bundle.main.object(forInfoDictionaryKey: "GITHUB_ACCESS_TOKEN") as? String)
                                Octokit(config).postIssue(owner: "Jonathan0827", repository: "WonsinheungMid", title: bugTitle, body: bugDescription, labels: ["bug"]) { response in
                                    switch response {
                                    case .success(let issue):
                                        issueLoading = false
                                        // do something with the issue
                                        print("success")
                                        issueSub = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                                            withAnimation { showBugRep.toggle() }
                                        })
                                    case .failure:
                                        issueLoading = false
                                        print("unexpected error occured while reporting issue")
                                        print(Error.self)
                                        // handle any errors
                                    }
                                }
                            }
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.blue)
                                
                                    .frame(width: 300, height: 70)
                                HStack{
                                    Text("제출")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                }.foregroundColor(Color("scheme"))
                                
                            }
                        })
                    } else if issueLoading {
                        ProgressView()
                    } else if issueSub {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("scheme"))
                            
                                .frame(width: 300, height: 70)
                            HStack{
                                Text("감사합니다!")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }.foregroundColor(.blue)
                            
                        }
                    } else {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("scheme"))
                            
                                .frame(width: 300, height: 70)
                            HStack{
                                Text("오류가 발생하였습니다")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }.foregroundColor(.red)
                            
                        }
                    }
                
                    //                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
                }
            
        }
        .alert(isPresented: $fillFormWarning) {
            Alert(title: Text("양식을 모두 작성해주세요"), message: nil)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                withAnimation { viewLoaded.toggle() }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation { secondViewLoaded.toggle() }
            })
        }
    }
}
