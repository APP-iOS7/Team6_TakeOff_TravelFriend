//
//  testView.swift
//  TravelFriend
//
//  Created by 이재용 on 2/6/25.
//

import SwiftUI
import Charts

struct ScrollableChartBug: View {

  /// Sample data
  let data = SampleData.samples
  let startDate = SampleData.samples.first?.startDate ?? Date()
  let endDate = Date()
  /// Scroll position of the chart, expressed as Date along the x-axis.
  @State var chartPosition: Date = SampleData.samples.first?.startDate ?? Date()
  /// Sets the granularity of the shown view.
  @State var visibleDomain: VisibleDomain = .year

  var body: some View {

    Chart(data, id: \.id) { element in
      BarMark(xStart: .value("Start", element.startDate),
              xEnd: .value("End", element.endDate),
              yStart: 0,
              yEnd: 50)
      .foregroundStyle(by: .value("Type", element.type.rawValue))
      .clipShape(.rect(cornerRadius: 8, style: .continuous))
    }
    .chartScrollableAxes(.horizontal) // enable scroll
    .chartScrollPosition(x: $chartPosition) // track scroll offset
    .chartXVisibleDomain(length: visibleDomain.seconds)
    .chartXScale(domain: startDate...endDate)
    .chartForegroundStyleScale { typeName in
      // custom colors for bars and for legend
      SampleDataType(rawValue: typeName)?.color ?? .clear
    }
    .chartXAxis {
      AxisMarks(values: .stride(by: .month, count: 1)) { value in
        if let date = value.as(Date.self) {
          AxisValueLabel {
            Text(date, format: .dateTime.year().month().day())
              .bold()
          }
          AxisTick(length: .label)
        }
      }
    }
    .frame(height: 90)
    .padding(.bottom, 40) // for overlay picker
    .overlay {
      Picker("", selection: $visibleDomain.animation()) {
        ForEach(VisibleDomain.allCases) { variant in
          Text(variant.label)
            .tag(variant)
        }
      }
      .pickerStyle(.segmented)
      .frame(width: 240)
      .padding(.trailing)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    } //: overlay
  } //: body
} //: struct

// MARK: - Preview
#Preview {
  ScrollableChartBug()
}

// MARK: - Data
enum SampleDataType: String, CaseIterable {
  case city, wood, field

  var color: Color {
    switch self {
    case .city:
        .gray
    case .wood:
        .green
    case .field:
        .brown
    }
  }

  var label: String {
    switch self {
    case .city:
      "City"
    case .wood:
      "Wood"
    case .field:
      "Field"
    }
  }
}

enum VisibleDomain: Identifiable, CaseIterable {

  case day
  case week
  case month
  case year

  var id: Int {
    self.seconds
  }

  var seconds: Int {
    switch self {
    case .day:
      3600 * 24 * 2
    case .week:
      3600 * 24 * 10
    case .month:
      3600 * 24 * 40
    case .year:
      3600 * 24 * 400
    }
  }

  var label: String {
    switch self {
    case .day:
      "Days"
    case .week:
      "Weeks"
    case .month:
      "Months"
    case .year:
      "Years"
    }
  }
}

struct SampleData: Identifiable {
  let startDate: Date
  let endDate: Date
  let name: String
  let type: SampleDataType
  var id: String { name }

  static let samples: [SampleData] = [
    .init(startDate: Date.from(year: 2022, month: 3, day: 1),
          endDate: Date.from(year: 2022, month: 3, day: 10),
          name: "New York",
          type: .city),
    .init(startDate: Date.from(year: 2022, month: 3, day: 20, hour: 6),
          endDate: Date.from(year: 2022, month: 5, day: 1),
          name: "London",
          type: .city),
    .init(startDate: Date.from(year: 2022, month: 5, day: 4),
          endDate: Date.from(year: 2022, month: 7, day: 5),
          name: "Backcountry ABC",
          type: .field),
    .init(startDate: Date.from(year: 2022, month: 7, day: 5),
          endDate: Date.from(year: 2022, month: 10, day: 10),
          name: "Field DEF",
          type: .field),
    .init(startDate: Date.from(year: 2022, month: 10, day: 10),
          endDate: Date.from(year: 2023, month: 2, day: 10),
          name: "Wood 123",
          type: .wood),
    .init(startDate: Date.from(year: 2023, month: 2, day: 10),
          endDate: Date.from(year: 2023, month: 3, day: 20),
          name: "Paris",
          type: .city),
    .init(startDate: Date.from(year: 2023, month: 3, day: 21),
          endDate: Date.from(year: 2023, month: 10, day: 5),
          name: "Field GHI",
          type: .field),
    .init(startDate: Date.from(year: 2023, month: 10, day: 5),
          endDate: Date.from(year: 2024, month: 3, day: 5),
          name: "Wood 456",
          type: .wood),
    .init(startDate: Date.from(year: 2024, month: 3, day: 6),
          endDate: Date(),
          name: "Field JKL",
          type: .field)
  ]
}

extension Date {
  /**
   Constructs a Date from a given year (Int). Use like `Date.from(year: 2020)`.
   */
  static func from(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil) -> Date {
    let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)
    guard let date = Calendar.current.date(from: components) else {
      print(#function, "Failed to construct date. Returning current date.")
      return Date()
    }
    return date
  }
}
