//
//  CalendarDayComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct WorkInterval: Identifiable {
    var id = UUID()
    var start: Int
    var end: Int
}

struct CalendarDayComponent: View {
    @EnvironmentObject var calendarManager: CalendarManager
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @State var selectedDay = 3
    @State var daysInMonth = 0
    
    var workIntervals: [WorkInterval] = [.init(start: 13, end: 18),
                                         .init(start: 7, end: 13),
                                         .init(start: 16, end: 20),
                                         .init(start: 9, end: 12)]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<daysInMonth+1, id:\.self) { day in
                        HStack(alignment: .top) {
                            Button {
                                withAnimation {
                                    selectedDay = day
                                }
                            } label: {
                                VStack {
                                    Text("\(day)").foregroundColor(selectedDay == day ? .black : .white)
                                    if let dayOfWeek = calendarManager.getAbbreviatedDayOfWeek(year: selectedYear, month: selectedMonth, day: day) {
                                        Text("\(dayOfWeek)").foregroundColor(selectedDay == day ? .black : .gray) .font(.custom("Urbanist-Regular", size: 14))
                                    }
                                }
                                .font(.custom("Urbanist-Regular", size: 14))
                                .padding(5)
                                .frame(width:40)
                                //.background(selectedDay == day ? Color(red: 18/255, green: 18/255, blue: 18/255) : .black)
                                .background(selectedDay == day ? Color("MainYellow") : .black)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                            }
                        }.frame(height: 60)
                    }.padding(.bottom)
                }
            }
            
            ScrollView(showsIndicators: false) {
                HStack(alignment:.top) {
                    // HOURS. Each hour has 50 height
                    VStack(alignment: .trailing, spacing: 0) {
                        ForEach(7..<24, id:\.self) { hour in
                            HStack(spacing: 0) {
                                Text("\(hour):00")
                                    .font(.custom("Urbanist-Regular", size: 14))
                                Spacer()
                                Text(hour < 12 ? "AM" : "PM")
                                    .foregroundColor(.gray)
                                    .font(.custom("Urbanist-Regular", size: 12))
                            }.frame(width:60, height: 50, alignment: .topLeading)
                        }
                    }
                    Divider()
                    // WORK
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment:.top) {
                            ForEach(calendarManager.work.filter{calendarManager.getDayOfMonthInt(from: $0.date ?? "") == selectedDay}) { work in
                                DayWorkView(height: CGFloat(4 * 50))
                                    .padding(.top, CGFloat((calendarManager.convertDateStringToDouble(work.date ?? "") ?? 7) - 7) * 50) // we use the date variable for test only
                            }
//                            ForEach(workIntervals) { workInterval in
//                                DayWorkView(height: CGFloat((workInterval.end - workInterval.start) * 50))
//                                    .padding(.top, CGFloat(workInterval.start - 7) * 50)
//                            }
                        }.frame(maxHeight: .infinity, alignment:.top)
                    }
                }
            }
        }
        .onAppear {
            daysInMonth = calendarManager.getDaysInMonth(selectedMonth) ?? 0
        }
        .onChange(of: selectedMonth) { newValue in
            daysInMonth = calendarManager.getDaysInMonth(selectedMonth) ?? 0
        }
//        VStack {
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(1...30, id:\.self) { day in
//                        Button {
//                            withAnimation {
//                                selectedDay = day
//                            }
//                        } label: {
//                            VStack {
//                                Text("\(day)")
//                                Text("Mo")
//                            }
//                            .font(.custom("Urbanist-Regular", size: 14))
//                            .padding(5)
//                            .frame(width:40)
//                            .background(selectedDay == day ? Color(red: 18/255, green: 18/255, blue: 18/255) : .black)
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//                        }
//                    }
//                }
//            }
//
//            ScrollView(.horizontal, showsIndicators: false) {
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 20) {
//                        HStack(alignment: .top) {
//                            VStack(alignment: .leading) {
//                                Text("7:00").foregroundColor(.gray).font(.custom("Urbanist-Regular", size: 14))
//                                Text("AM").font(.custom("Urbanist-Regular", size: 16))
//                            }.frame(width:30, alignment: .leading)
//                            DayWorkView()
//                            DayWorkView()
//                            DayWorkView()
//                            VStack(alignment: .leading) {
//                                Text("Windows")
//                                Text("BRD Hall")
//                                Spacer()
//                                HStack{
//                                    Image(systemName: "clock")
//                                    Text("7:00 - 11:00")
//                                }
//                            }
//                            .padding(5)
//                            .foregroundColor(Color(red: 61/101, green:64/255, blue: 30/255))
//                            .bold()
//                            .frame(width: 100, height:100, alignment: .topLeading)
//                            .background(Color(red: 233/255, green: 245/255, blue: 114/255))
//                            .cornerRadius(5)
//                            .font(.custom("Urbanist-Regular", size: 12))
//                        }.frame(height: 100)
//                        HStack(alignment: .top) {
//                            VStack(alignment: .leading) {
//                                Text("8:00").foregroundColor(.gray).font(.custom("Urbanist-Regular", size: 14))
//                                Text("AM").font(.custom("Urbanist-Regular", size: 16))
//                            }.frame(width:30, alignment: .leading)
//                            VStack(alignment: .leading) {
//                                Text("Windows")
//                                Text("BRD Hall")
//                                Spacer()
//                                HStack{
//                                    Image(systemName: "clock")
//                                    Text("7:00 - 11:00")
//                                }
//                            }
//                            .padding(5)
//                            .foregroundColor(Color(red: 78/101, green:63/255, blue: 62/255))
//                            .bold()
//                            .frame(width: 100, height:100, alignment: .topLeading)
//                            .background(Color(red: 238/255, green: 195/255, blue: 188/255))
//                            .cornerRadius(5)
//                            .font(.custom("Urbanist-Regular", size: 12))
//                        }.frame(height: 100)
//                        HStack {
//                            VStack {
//                                Text("9:00").foregroundColor(.gray).font(.custom("Urbanist-Regular", size: 14))
//                                Text("AM").font(.custom("Urbanist-Regular", size: 16))
//                            }
//                        }.frame(height: 100)
//                    }.frame(maxWidth: .infinity, alignment: .leading)
//                }
//            }
//        }
    }
}

struct CalendarDayComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDayComponent(selectedYear: .constant(1), selectedMonth: .constant(1)).environmentObject(CalendarManager())
    }
}

struct DayWorkView: View {
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Windows").font(.custom("Urbanist-Regular", size: 12))
            Text("BRD Hall").font(.custom("Urbanist-Regular", size: 12))
            Spacer()
            HStack{
                Image(systemName: "clock")
                Text("7:00 - 11:00")
            }.font(.custom("Urbanist-Regular", size: 10))
        }
        .padding(5)
        .foregroundColor(Color(red: 17/101, green: 56/255, blue: 24/255))
        .bold()
        .frame(width: 100, height:height, alignment: .topLeading)
        .background(.green)
        .cornerRadius(5)
        .font(.custom("Urbanist-Regular", size: 12))
    }
}
