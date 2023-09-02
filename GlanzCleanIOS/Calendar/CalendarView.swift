//
//  CalendarView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 15.08.2023.
//

import SwiftUI

struct CalendarView: View {
    @State var selectedView: CalendarTypeEnum = .list
    @EnvironmentObject var toastManager: ToastManager
    @StateObject var calendarManager = CalendarManager()
    @State var isLoading = false
    @State var selectedYear = Calendar.current.component(.year, from: Date())
    @State var selectedMonth:Int = Calendar.current.component(.month, from: Date())
    @State var selectedDay = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Text("Calendar")
                        .foregroundColor(.white)
                        .font(.custom("Urbanist-Bold", size: 28))
                        .padding(.leading)
                    Spacer()
                    
                }
                CalendarHeaderComponent(selectedView: $selectedView, selectedYear: $selectedYear, selectedMonth: $selectedMonth, selectedDay: $selectedDay, isLoading: $isLoading)
                    .environmentObject(toastManager)
                    .environmentObject(calendarManager)
                    .overlay(
                        Circle()
                            .fill(Color("MainYellow"))
                            .frame(width: 150)
                            .offset(x: 200, y: -110)
                    )
                if selectedView == .day {
                    CalendarDayComponent(selectedYear: $selectedYear, selectedMonth: $selectedMonth)
                        .environmentObject(calendarManager)
                }
                else if selectedView == .month {
                    CalendarMonthComponent(selectedYear: $selectedYear, selectedMonth: $selectedMonth)
                        .environmentObject(calendarManager)
                        .padding(.top)
                }
                else {
                    CalendarListComponent(selectedMonth: $selectedMonth)
                        .environmentObject(calendarManager)
                        .padding(.top)
                }
                Spacer()
            }
            .disabled(isLoading)
            if isLoading {
                LoadingView(loadingType: .download).brightness(0.5)
            }
        }
        .brightness(isLoading ? -0.5 : 0)
        .onAppear {
            isLoading = true
            calendarManager.getWork(year:selectedYear, month: selectedMonth, day: Int(selectedDay)) { response in
                isLoading = false
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(ToastManager())
    }
}







