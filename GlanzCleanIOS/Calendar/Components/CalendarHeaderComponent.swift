//
//  CalendarHeaderComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

enum CalendarTypeEnum: String, CaseIterable {
    case day = "Day"
    case month = "Month"
    case list = "List"
}


struct CalendarHeaderComponent: View {
    @EnvironmentObject var toastManager: ToastManager
    @EnvironmentObject var calendarManager: CalendarManager
    var views:[CalendarTypeEnum] = [.day, .month, .list]
    @Binding var selectedView: CalendarTypeEnum
    @State var showMonths = true
    @State var showDaysMonthPicker = true
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @Binding var selectedDay: String
    @Binding var isLoading: Bool
    
    var months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]
    
    //@State var selected = "January"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottomLeading) {
                Image("CalendarImg")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 130)
                HStack {
                    Image(systemName: "calendar")
                    Text("2023")
                        .font(.custom("Urbanist-Regular", size: 28))
                    Spacer()
                    HStack(spacing: 12) {
                        Button {
                            withAnimation {
                                showMonths.toggle()
                            }
                        }label: {
                            Image(systemName: "eye.slash.fill")
                                .font(.callout)
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                        Button {
                            withAnimation {
                                showDaysMonthPicker.toggle()
                            }
                        }label: {
                            Image(systemName: "eye.slash")
                                .font(.callout)
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                        NavigationLink {
                            AddWorkView().environmentObject(toastManager)
                        }label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .frame(width: 25, height: 25)
                                .padding(5)
                                .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                        Image(systemName: "chart.bar.xaxis")
                            .font(.title2)
                            .frame(width: 25, height: 25)
                            .padding(5)
                            .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }.font(.title)
            }.padding(.bottom, 10).padding(.horizontal)
            if showDaysMonthPicker {
                Picker("", selection: $selectedView) {
                    ForEach(views, id:\.self) { view in
                        Text(view.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                
            }
            if showMonths {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment:.top) {
                            ForEach(0..<months.count, id:\.self) { month in
                                Button {
                                    withAnimation {
                                        selectedMonth = month + 1
                                    }
                                }label: {
                                    VStack {
                                        VStack {
                                            Rectangle()
                                                //.fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                                                .fill(Color("MainYellow"))
                                                .frame(height: 10)
                                            Text(months[month])
                                                .padding(.horizontal)
                                                .font(.custom("Urbanist-Bold", size: 14))
                                            
                                        }
                                        .frame(width: 100, height: 40, alignment:.top)
                                        .font(.caption)
                                        .bold()
                                        .background(Color(red: 18/255, green: 18/255, blue: 18/255))
                                        .cornerRadius(5)
                                        //.scaleEffect(selected == month ? 1.2 : 1)
                                        .scaleEffect(selectedMonth == month + 1 ? 1.2 : 1)
                                        //.padding(.horizontal, selected == month ? 10 : 0)
                                        .padding(.horizontal, selectedMonth == month + 1 ? 10 : 0)
                                        if month + 1 == selectedMonth {
                                            Rectangle()
                                                //.fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                                                .fill(Color("MainYellow"))
                                                .frame(height: 2)
                                                .cornerRadius(10)
                                        }
                                    }.foregroundColor(.white)
                                }.onAppear {
                                    proxy.scrollTo(month)
                                }
                                .onChange(of: selectedMonth) { newValue in
                                    if isLoading == false {
                                        isLoading = true
                                        calendarManager.getWork(year:selectedYear, month: selectedMonth, day: Int(selectedDay)) { response in
                                            isLoading = false
                                        }
                                    }
                                }
                                
                            }
                        }.frame(height: 60)
                    }
                }
            }
            

        }
    }
}


struct GlowButtonComponent: View {
    var diameter: CGFloat = 40
    var title: String = "AA"
    var text: String = "BB"
    @State var progress: CGFloat = 0.75
    @State var show = false
    var body: some View {
        ZStack {
            // PLUS
            ZStack {
                Rectangle()
                    .fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                    .cornerRadius(10)
                    .blur(radius: 1)
                    .frame(width:2.5, height:20)
                Rectangle()
                    .fill(Color(red: 208/255, green: 219/255, blue: 248/255))

                    .cornerRadius(10)
                    .frame(width:2.5, height:20)
                Rectangle()
                    .fill(Color(red: 208/255, green: 219/255, blue: 248/255))

                    .cornerRadius(10)
                    .blur(radius: 1)
                    .frame(width:20, height:2.5)
                Rectangle()
                    .fill(Color(red: 208/255, green: 219/255, blue: 248/255))

                    .cornerRadius(10)
                    .frame(width:20, height:2.5)
            }
            // CIRLCE
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(red: 208/255, green: 219/255, blue: 248/255), lineWidth: 3)
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -90))
                .blur(radius: 1)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(red: 208/255, green: 219/255, blue: 248/255), lineWidth: 3)
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -90))
                .blur(radius: 1)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(red: 208/255, green: 219/255, blue: 248/255), lineWidth: 3)
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -90))
                .blur(radius: 1)
        }
    }
}


struct GlowButtonComponentStats: View {
    var diameter: CGFloat = 40
    var title: String = "AA"
    var text: String = "BB"
    @State var progress: CGFloat = 0.75
    @State var show = false
    var body: some View {
        ZStack {
            // PLUS
            ZStack {
                HStack(alignment: .bottom, spacing: 3) {
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                            .cornerRadius(10)
                            .blur(radius: 1)
                            .frame(width:2.5, height:20)
                        Rectangle()
                            .fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                            .cornerRadius(10)
                            .frame(width:2.5, height:20)
                    }
                    ZStack {
                        Rectangle()
                            .fill(LinearGradient(
                                gradient: .init(colors: [.blue, .purple, .blue, .purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .cornerRadius(10)
                            .blur(radius: 1)
                            .frame(width:2.5, height:17)
                        Rectangle()
                            .fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                            .cornerRadius(10)
                            .frame(width:2.5, height:17)
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                            .cornerRadius(10)
                            .blur(radius: 1)
                            .frame(width:2.5, height:13)
                        Rectangle()
                            .fill(Color(red: 208/255, green: 219/255, blue: 248/255))
                            .cornerRadius(10)
                            .frame(width:2.5, height:13)
                    }
                }
            }
            // CIRLCE
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(red: 208/255, green: 219/255, blue: 248/255), lineWidth: 3)
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -90))
                .blur(radius: 1)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(red: 208/255, green: 219/255, blue: 248/255), lineWidth: 3)
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -90))
                .blur(radius: 1)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(red: 208/255, green: 219/255, blue: 248/255), lineWidth: 3)
                .frame(width: diameter, height: diameter)
                .rotationEffect(Angle(degrees: -90))
                .blur(radius: 1)
        }
    }
}
