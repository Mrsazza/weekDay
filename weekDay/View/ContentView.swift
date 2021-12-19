//
//  ContentView.swift
//  weekDay
//
//  Created by Sazza on 19/12/21.
//

import SwiftUI
import Darwin

struct ContentView: View {
    @State private var dayArr:[String] = []
    
    @State private var friIsSelected = false
    @State private var satIsSelected = false
    @State private var sunIsSelected = false
    @State private var monIsSelected = false
    @State private var tueIsSelected = false
    @State private var wedIsSelected = false
    @State private var thuIsSelected = false
    @State private var today = Date()
    @State private var selectedDaysArr:[Date] = []
    @State private var endDay = EndOption.Weekly.rawValue
    @State private var isChecked = false
    
    func removeFromArr(dayRaw: String){
        if let index = dayArr.firstIndex(of: dayRaw){
            dayArr.remove(at: index)
        }
    }
    
    var body: some View {
        VStack {
            
            HStack{
                Button(action: {
                    isChecked = false
                    endDay = EndOption.Weekly.rawValue
                }, label: {
                    HStack{
                        Image(systemName: isChecked ? "square": "checkmark.square")
                            .foregroundColor(.black)
                        Text("Weekly")
                            .foregroundColor(.black)
                    }
                })
                Button(action: {
                    isChecked = true
                    endDay = EndOption.Monthly.rawValue
                }, label: {
                    HStack{
                        Image(systemName: isChecked ? "checkmark.square": "square")
                            .foregroundColor(.black)
                        Text("Monthly")
                            .foregroundColor(.black)
                    }
                })
            }
            .padding(.top)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Today:")
                    Text("\(today, format: .dateTime.day().month().year())")
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("EndDate:")
                    Text("\(getEndDay(today:today,endDay: endDay),format: .dateTime.day().month().year())")
                }
            }
            .padding()
            
            Text("Select Day's")
                .font(.headline)
            
            HStack{
                Button("F"){
                    friIsSelected.toggle()
                    friIsSelected ? dayArr.append(WeekDay.Friday.rawValue) : removeFromArr(dayRaw: WeekDay.Friday.rawValue)
                }.buttonStyle(DaySelectorButtonStyle(isSelected: friIsSelected))
                Button("S"){
                    satIsSelected.toggle()
                    satIsSelected ? dayArr.append(WeekDay.Saturday.rawValue) : removeFromArr(dayRaw: WeekDay.Saturday.rawValue)
                }
                .buttonStyle(DaySelectorButtonStyle(isSelected: satIsSelected))
                Button("S"){
                    sunIsSelected.toggle()
                    sunIsSelected ? dayArr.append(WeekDay.Sunday.rawValue) : removeFromArr(dayRaw: WeekDay.Sunday.rawValue)
                }
                .buttonStyle(DaySelectorButtonStyle(isSelected: sunIsSelected))
                Button("M"){
                    monIsSelected.toggle()
                    monIsSelected ? dayArr.append(WeekDay.Monday.rawValue) : removeFromArr(dayRaw: WeekDay.Monday.rawValue)
                }
                .buttonStyle(DaySelectorButtonStyle(isSelected: monIsSelected))
                Button("T"){
                    tueIsSelected.toggle()
                    tueIsSelected ? dayArr.append(WeekDay.Tuesday.rawValue) : removeFromArr(dayRaw: WeekDay.Tuesday.rawValue)
                }
                .buttonStyle(DaySelectorButtonStyle(isSelected: tueIsSelected))
                Button("W"){
                    wedIsSelected.toggle()
                    wedIsSelected ? dayArr.append(WeekDay.Wednesday.rawValue) : removeFromArr(dayRaw: WeekDay.Wednesday.rawValue)
                }
                .buttonStyle(DaySelectorButtonStyle(isSelected: wedIsSelected))
                Button("T"){
                    thuIsSelected.toggle()
                    thuIsSelected ? dayArr.append(WeekDay.Thursday.rawValue) : removeFromArr(dayRaw: WeekDay.Thursday.rawValue)
                }
                .buttonStyle(DaySelectorButtonStyle(isSelected: thuIsSelected))
            }//: HSTACK
                .padding()
            
            Button(action: {
               selectedDaysArr = generateDates(between: today, and: getEndDay(today: today, endDay: endDay), selectedDays: dayArr)
            }, label: {
                Text("Get The Selected Days")
            })
            
            List(selectedDaysArr, id:\.self) { day in
                Text("\(getTodayWeekDay(of:day)), \(day, format: .dateTime.day().month().year())")
            }
            
//
//            List(dayArr, id:\.self){ day in
//                if day == getTodayWeekDay(of: today){
//                    HStack{
//                        Text(day)
//                            .font(.largeTitle)
//                            .foregroundColor(.red)
//                        Spacer()
//                        Text("Today")
//                            .font(.callout)
//                    }
//                }else{
//                    Text(day)
//                }
//            }
        }//: VSTACK
    }
}

// Takes a date and return only week day in string.
func getTodayWeekDay(of:Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let weekDay = dateFormatter.string(from: of)
    return weekDay
}

// Takes a date and returns an end day
func getEndDay(today: Date, endDay: Int) -> Date{
    Calendar.current.date(byAdding: .day, value: endDay, to: today)!
}

// Returns dates of selectedDays
func generateDates(between startDate: Date?, and endDate: Date?, selectedDays: [String]) -> [Date] {
    var dates = [Date]()
    guard var date = startDate, let endDate = endDate else {
        return []
    }
    while date < endDate {
        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        if selectedDays.contains(getTodayWeekDay(of: date)){
            dates.append(date)
        }
    }
    return dates
}


enum WeekDay:String {
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
}

enum EndOption: Int{
    case Weekly = 7
    case Monthly = 30
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
