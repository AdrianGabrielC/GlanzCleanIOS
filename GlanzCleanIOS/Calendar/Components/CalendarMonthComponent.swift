//
//  CalendarMonthComponent.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct CalendarMonthComponent: View {
    @EnvironmentObject var calendarManager: CalendarManager
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int
    @State var selectedDay = 3
    @State var daysInMonth = 0
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(1..<daysInMonth+1, id:\.self) { day in
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                if let dayOfWeek = calendarManager.getAbbreviatedDayOfWeek(year: selectedYear, month: selectedMonth, day: day) {
                                    Text("\(dayOfWeek)").foregroundColor(.gray).font(.footnote)
                                }
                                
                                Text("\(day)").font(.title3)
                            }.frame(width:30, alignment: .leading)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    // For each work, if work.date.day == day, show.
                                    ForEach(calendarManager.work.filter{calendarManager.getDayOfMonthInt(from: $0.date ?? "") == day}, id:\.id) { work in
                                        DayWorkView(height: 60)
                                        
                                    }
                                }
                            }
                       
                        }.frame(height: 60)
                    }.padding(.bottom)
                        
                    
                    
              
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            daysInMonth = calendarManager.getDaysInMonth(selectedMonth) ?? 0
        }
        .onChange(of: selectedMonth) { newValue in
            daysInMonth = calendarManager.getDaysInMonth(selectedMonth) ?? 0
        }
    }
}

struct CalendarMonthComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarMonthComponent( selectedYear: .constant(1), selectedMonth: .constant(1)).environmentObject(CalendarManager())
    }
}
