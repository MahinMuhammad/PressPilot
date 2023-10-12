//
//  NewsFilterView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/12/23.
//

import SwiftUI

struct NewsFilterView: View {
    @StateObject var viewModel = NewsFilterViewModel()
    @StateObject var rs = RequestManager.shared
    var body: some View {
        ZStack{
            Color(K.CustomColors.bluishWhiteToBlack)
                .edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 110)
                        .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                        .overlay{
                            VStack(spacing: 8){
                                HStack{
                                    Picker(selection: $rs.selectedLanguage, label: PickerLabelView(imageName: "doc.plaintext", title: "Language")) {
                                        ForEach(rs.languages) { language in
                                            Text(language.language).tag(language.id)
                                        }
                                    }
                                    .foregroundColor(Color(UIColor.label))
                                    .pickerStyle(.navigationLink)
                                    
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color(UIColor.lightGray))
                                }
                                
                                Divider()
                                
                                HStack{
                                    Picker(selection: $rs.selectedCountry, label: PickerLabelView(imageName: "globe", title: "Country"))
                                    {
                                        ForEach(rs.countries) { country in
                                            Text(country.country).tag(country.id)
                                        }
                                    }
                                    .foregroundColor(Color(UIColor.label))
                                    .pickerStyle(.navigationLink)
                                    
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color(UIColor.lightGray))
                                }
                            }
                            .padding()
                        }
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 110)
                        .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                        .overlay{
                            VStack(spacing: 8){
                                HStack{
                                    Picker(selection: $rs.selectedLangOrCntry, label: PickerLabelView(imageName: "checklist", title: "Show News by")) {
                                        ForEach(rs.choicesLangOrCntry, id: \.self) {
                                            Text($0).tag($0)
                                        }
                                    }
                                    .foregroundColor(Color(UIColor.label))
                                    .pickerStyle(.navigationLink)
                                    
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color(UIColor.lightGray))
                                }
                                
                                Divider()
                                
                                HStack{
                                    Picker(selection: $rs.pageSize, label: PickerLabelView(imageName: "number.square", title: "No. of News"))
                                    {
                                        ForEach(rs.oferedPageSizes, id:\.self) {
                                            Text($0).tag($0)
                                        }
                                    }
                                    .foregroundColor(Color(UIColor.label))
                                    .pickerStyle(.navigationLink)
                                    
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color(UIColor.lightGray))
                                }
                            }
                            .padding()
                        }
                }
                .padding()
            }
        }
        .navigationTitle("News Filter")
    }
}

#Preview {
    NewsFilterView()
}
