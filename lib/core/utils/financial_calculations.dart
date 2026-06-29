import 'dart:math';

/// Financial Calculation Utilities
/// Contains all financial formulas and calculations for the ERP system
class FinancialCalculations {
  // Private constructor to prevent instantiation
  FinancialCalculations._();

  /// Gross Profit = Total Revenue - Cost of Goods Sold (COGS)
  static double calculateGrossProfit({
    required double totalRevenue,
    required double costOfGoodsSold,
  }) {
    return totalRevenue - costOfGoodsSold;
  }

  /// Net Profit = Gross Profit - Operating Expenses - Taxes - Interest
  static double calculateNetProfit({
    required double grossProfit,
    required double operatingExpenses,
    required double taxes,
    required double interest,
  }) {
    return grossProfit - operatingExpenses - taxes - interest;
  }

  /// Gross Profit Margin = (Gross Profit / Revenue) × 100
  static double calculateGrossProfitMargin({
    required double grossProfit,
    required double revenue,
  }) {
    if (revenue == 0) return 0.0;
    return (grossProfit / revenue) * 100;
  }

  /// Net Profit Margin = (Net Profit / Revenue) × 100
  static double calculateNetProfitMargin({
    required double netProfit,
    required double revenue,
  }) {
    if (revenue == 0) return 0.0;
    return (netProfit / revenue) * 100;
  }

  /// EBITDA = Net Profit + Interest + Taxes + Depreciation + Amortization
  static double calculateEBITDA({
    required double netProfit,
    required double interest,
    required double taxes,
    required double depreciation,
    required double amortization,
  }) {
    return netProfit + interest + taxes + depreciation + amortization;
  }

  /// Operating Profit = Gross Profit - Operating Expenses
  static double calculateOperatingProfit({
    required double grossProfit,
    required double operatingExpenses,
  }) {
    return grossProfit - operatingExpenses;
  }

  /// ROI = ((Final Value - Initial Value) / Initial Value) × 100
  static double calculateROI({
    required double initialValue,
    required double finalValue,
  }) {
    if (initialValue == 0) return 0.0;
    return ((finalValue - initialValue) / initialValue) * 100;
  }

  /// Year-over-Year Growth = ((Current Year Value - Previous Year Value) / Previous Year Value) × 100
  static double calculateYoYGrowth({
    required double currentValue,
    required double previousValue,
  }) {
    if (previousValue == 0) return 0.0;
    return ((currentValue - previousValue) / previousValue) * 100;
  }

  /// Monthly Growth Rate
  static double calculateMonthlyGrowth({
    required double currentValue,
    required double previousMonthValue,
  }) {
    if (previousMonthValue == 0) return 0.0;
    return ((currentValue - previousMonthValue) / previousMonthValue) * 100;
  }

  /// Burn Rate = Average Monthly Expenses
  static double calculateBurnRate({
    required List<double> monthlyExpenses,
  }) {
    if (monthlyExpenses.isEmpty) return 0.0;
    return monthlyExpenses.reduce((a, b) => a + b) / monthlyExpenses.length;
  }

  /// Runway = Current Cash / Burn Rate (in months)
  static double calculateRunway({
    required double currentCash,
    required double burnRate,
  }) {
    if (burnRate == 0) return 0.0;
    return currentCash / burnRate;
  }

  /// Current Ratio = Current Assets / Current Liabilities
  static double calculateCurrentRatio({
    required double currentAssets,
    required double currentLiabilities,
  }) {
    if (currentLiabilities == 0) return 0.0;
    return currentAssets / currentLiabilities;
  }

  /// Debt-to-Equity Ratio = Total Liabilities / Shareholder Equity
  static double calculateDebtToEquityRatio({
    required double totalLiabilities,
    required double shareholderEquity,
  }) {
    if (shareholderEquity == 0) return 0.0;
    return totalLiabilities / shareholderEquity;
  }

  /// Asset Turnover = Revenue / Total Assets
  static double calculateAssetTurnover({
    required double revenue,
    required double totalAssets,
  }) {
    if (totalAssets == 0) return 0.0;
    return revenue / totalAssets;
  }

  /// Cash Flow = Operating Cash Flow - Investing Cash Flow - Financing Cash Flow
  static double calculateCashFlow({
    required double operatingCashFlow,
    required double investingCashFlow,
    required double financingCashFlow,
  }) {
    return operatingCashFlow - investingCashFlow - financingCashFlow;
  }

  /// Operating Cash Flow Ratio = Operating Cash Flow / Current Liabilities
  static double calculateOperatingCashFlowRatio({
    required double operatingCashFlow,
    required double currentLiabilities,
  }) {
    if (currentLiabilities == 0) return 0.0;
    return operatingCashFlow / currentLiabilities;
  }

  /// Working Capital = Current Assets - Current Liabilities
  static double calculateWorkingCapital({
    required double currentAssets,
    required double currentLiabilities,
  }) {
    return currentAssets - currentLiabilities;
  }

  /// Quick Ratio = (Current Assets - Inventory) / Current Liabilities
  static double calculateQuickRatio({
    required double currentAssets,
    required double inventory,
    required double currentLiabilities,
  }) {
    if (currentLiabilities == 0) return 0.0;
    return (currentAssets - inventory) / currentLiabilities;
  }

  /// EMI Calculation using reducing balance method
  /// EMI = [P x R x (1+R)^N] / [(1+R)^N-1]
  static double calculateEMI({
    required double principal,
    required double annualRate,
    required int tenureInMonths,
  }) {
    if (principal == 0 || tenureInMonths == 0) return 0.0;

    double monthlyRate = annualRate / 12 / 100;
    double emi;

    if (monthlyRate == 0) {
      emi = principal / tenureInMonths;
    } else {
      double compound = pow(1 + monthlyRate, tenureInMonths).toDouble();
      emi = (principal * monthlyRate * compound) / (compound - 1);
    }

    return emi;
  }

  /// Compound Interest = P(1 + r/n)^(nt) - P
  static double calculateCompoundInterest({
    required double principal,
    required double annualRate,
    required int years,
    int compoundingPeriodsPerYear = 1,
  }) {
    double rate = annualRate / 100;
    double n = compoundingPeriodsPerYear.toDouble();
    double t = years.toDouble();

    double amount = principal * pow(1 + rate / n, n * t);
    return amount - principal;
  }

  /// Simple Interest = (P × R × T) / 100
  static double calculateSimpleInterest({
    required double principal,
    required double annualRate,
    required int timeInYears,
  }) {
    return (principal * annualRate * timeInYears) / 100;
  }

  /// Depreciation (Straight Line Method) = (Cost - Salvage Value) / Useful Life
  static double calculateDepreciation({
    required double cost,
    required double salvageValue,
    required int usefulLifeInYears,
  }) {
    if (usefulLifeInYears == 0) return 0.0;
    return (cost - salvageValue) / usefulLifeInYears;
  }

  /// Gross Margin = (Revenue - COGS) / Revenue × 100
  static double calculateGrossMargin({
    required double revenue,
    required double costOfGoodsSold,
  }) {
    if (revenue == 0) return 0.0;
    return ((revenue - costOfGoodsSold) / revenue) * 100;
  }

  /// Markup Percentage = ((Selling Price - Cost) / Cost) × 100
  static double calculateMarkupPercentage({
    required double sellingPrice,
    required double cost,
  }) {
    if (cost == 0) return 0.0;
    return ((sellingPrice - cost) / cost) * 100;
  }

  /// Break-even Point (units) = Fixed Costs / (Price per Unit - Variable Cost per Unit)
  static double calculateBreakEvenPoint({
    required double fixedCosts,
    required double pricePerUnit,
    required double variableCostPerUnit,
  }) {
    double contributionMargin = pricePerUnit - variableCostPerUnit;
    if (contributionMargin == 0) return 0.0;
    return fixedCosts / contributionMargin;
  }

  /// Calculate Tax Amount
  static double calculateTax({
    required double amount,
    required double taxRate,
  }) {
    return amount * (taxRate / 100);
  }

  /// Calculate Net Revenue (after refunds)
  static double calculateNetRevenue({
    required double grossRevenue,
    required double refunds,
    required double discounts,
  }) {
    return grossRevenue - refunds - discounts;
  }

  /// Calculate Accounts Receivable Turnover = Net Credit Sales / Average Accounts Receivable
  static double calculateAccountsReceivableTurnover({
    required double netCreditSales,
    required double averageAccountsReceivable,
  }) {
    if (averageAccountsReceivable == 0) return 0.0;
    return netCreditSales / averageAccountsReceivable;
  }

  /// Calculate Average Collection Period = 365 / Receivables Turnover
  static double calculateAverageCollectionPeriod({
    required double receivablesTurnover,
  }) {
    if (receivablesTurnover == 0) return 0.0;
    return 365 / receivablesTurnover;
  }

  /// Calculate Inventory Turnover = Cost of Goods Sold / Average Inventory
  static double calculateInventoryTurnover({
    required double costOfGoodsSold,
    required double averageInventory,
  }) {
    if (averageInventory == 0) return 0.0;
    return costOfGoodsSold / averageInventory;
  }

  /// Calculate Days Sales Outstanding = (Accounts Receivable / Total Credit Sales) × 365
  static double calculateDaysSalesOutstanding({
    required double accountsReceivable,
    required double totalCreditSales,
  }) {
    if (totalCreditSales == 0) return 0.0;
    return (accountsReceivable / totalCreditSales) * 365;
  }

  /// Calculate Working Capital Turnover = Sales / Working Capital
  static double calculateWorkingCapitalTurnover({
    required double sales,
    required double workingCapital,
  }) {
    if (workingCapital == 0) return 0.0;
    return sales / workingCapital;
  }

  /// Forecast future value using linear regression
  static List<double> forecastLinearGrowth({
    required List<double> historicalData,
    required int forecastPeriods,
  }) {
    if (historicalData.length < 2) return [];

    // Calculate average growth rate
    List<double> growthRates = [];
    for (int i = 1; i < historicalData.length; i++) {
      if (historicalData[i - 1] != 0) {
        growthRates.add(
          (historicalData[i] - historicalData[i - 1]) / historicalData[i - 1],
        );
      }
    }

    if (growthRates.isEmpty) return [];

    double avgGrowthRate =
        growthRates.reduce((a, b) => a + b) / growthRates.length;
    double lastValue = historicalData.last;

    List<double> forecast = [];
    for (int i = 1; i <= forecastPeriods; i++) {
      double forecastedValue = lastValue * (1 + avgGrowthRate * i);
      forecast.add(forecastedValue);
    }

    return forecast;
  }

  /// Calculate moving average for smoothing data
  static List<double> calculateMovingAverage({
    required List<double> data,
    required int windowSize,
  }) {
    if (data.isEmpty || windowSize <= 0 || windowSize > data.length) {
      return [];
    }

    List<double> movingAverages = [];
    for (int i = windowSize - 1; i < data.length; i++) {
      double sum = 0;
      for (int j = i - windowSize + 1; j <= i; j++) {
        sum += data[j];
      }
      movingAverages.add(sum / windowSize);
    }

    return movingAverages;
  }

  /// Calculate percentage change between two values
  static double calculatePercentageChange({
    required double oldValue,
    required double newValue,
  }) {
    if (oldValue == 0) return 0.0;
    return ((newValue - oldValue) / oldValue) * 100;
  }

  /// Calculate weighted average
  static double calculateWeightedAverage({
    required List<double> values,
    required List<double> weights,
  }) {
    if (values.isEmpty || values.length != weights.length) return 0.0;

    double weightedSum = 0;
    double weightSum = 0;

    for (int i = 0; i < values.length; i++) {
      weightedSum += values[i] * weights[i];
      weightSum += weights[i];
    }

    if (weightSum == 0) return 0.0;
    return weightedSum / weightSum;
  }
}