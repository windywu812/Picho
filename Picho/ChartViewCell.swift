//
//  ChartViewCell.swift
//  Picho
//
//  Created by Windy on 25/11/20.
//

import UIKit

class ChartViewCell: UIView {
    static let reuseIdentifier = "ChartViewCell"

    let chartView = ChartView()
    var timeLabel: UILabel!
    var viewModel: HistoryViewModel?

    func setupChart(month: Int = Date().month, week: Int = Date().weekOfMonth) {
        guard let viewModel = viewModel else { return }
        chartView.setupChartData(dataWeekPerMonth: viewModel.getDataWeekofMonth(in: month))

        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"

        let firstDateOfWeek = formatter.string(from: viewModel.getDataWeekofMonth(in: month)[week]?.first?.date ?? Date())
        let lastDataOfWeek = formatter.string(from: viewModel.getDataWeekofMonth(in: month)[week]?.last?.date ?? Date())

        timeLabel.text = "\(firstDateOfWeek) - \(lastDataOfWeek)"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = Color.background

        addSubview(chartView)
        chartView.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 12,
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -12,
            heighAnchorConstant: 336
        )

        let sugarLegend = LegendView(text: NSLocalizedString("Sugar", comment: ""), color: Color.green)
        let satFatLegend = LegendView(text: NSLocalizedString("Saturated Fat", comment: ""), color: Color.yellow)

        addSubview(sugarLegend)
        addSubview(satFatLegend)

        timeLabel = UILabel()
        timeLabel.setFont(text: "2 Nov - 8 Nov", size: 22, weight: .bold)
        addSubview(timeLabel)

        sugarLegend.setConstraint(
            topAnchor: chartView.bottomAnchor, topAnchorConstant: 8,
            leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 12,
            heighAnchorConstant: 44,
            widthAnchorConstant: UIScreen.main.bounds.width / 2 - 24
        )

        satFatLegend.setConstraint(
            topAnchor: chartView.bottomAnchor, topAnchorConstant: 8,
            leadingAnchor: sugarLegend.trailingAnchor, leadingAnchorConstant: 8,
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -12,
            heighAnchorConstant: 44
        )

        timeLabel.setConstraint(
            topAnchor: sugarLegend.bottomAnchor, topAnchorConstant: 24,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 12
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
