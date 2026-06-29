/// App-wide constants for the Business Finance Management System
class AppConstants {
  // App Information
  static const String appName = 'NTech Profit';
  static const String appVersion = '1.0.0';
  static const String companyName = 'NTech Solutions';

  // Appwrite Configuration
  static const String appwriteEndpoint = 'https://cloud.appwrite.io/v1';
  static const String appwriteProjectId = 'your-project-id';
  static const String appwriteDatabaseId = 'your-database-id';

  // Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyUserRole = 'user_role';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  // Collection Names
  static const String collectionUsers = 'users';
  static const String collectionCompanies = 'companies';
  static const String collectionTransactions = 'transactions';
  static const String collectionCategories = 'categories';
  static const String collectionClients = 'clients';
  static const String collectionVendors = 'vendors';
  static const String collectionEmployees = 'employees';
  static const String collectionInvoices = 'invoices';
  static const String collectionLoans = 'loans';
  static const String collectionAssets = 'assets';
  static const String collectionBankAccounts = 'bank_accounts';
  static const String collectionInvestments = 'investments';
  static const String collectionReports = 'reports';
  static const String collectionNotifications = 'notifications';
  static const String collectionSettings = 'settings';

  // User Roles
  static const String roleSuperAdmin = 'super_admin';
  static const String roleOwner = 'owner';
  static const String roleAccountant = 'accountant';
  static const String roleHR = 'hr';
  static const String roleManager = 'manager';
  static const String roleEmployee = 'employee';
  static const String roleReadOnly = 'read_only';

  // Transaction Types
  static const String txnIncome = 'income';
  static const String txnExpense = 'expense';
  static const String txnInvestment = 'investment';
  static const String txnWithdrawal = 'withdrawal';
  static const String txnTransfer = 'transfer';
  static const String txnBankDeposit = 'bank_deposit';
  static const String txnBankWithdraw = 'bank_withdraw';
  static const String txnLoan = 'loan';
  static const String txnLoanPayment = 'loan_payment';
  static const String txnTax = 'tax';
  static const String txnRefund = 'refund';
  static const String txnAdjustment = 'adjustment';
  static const String txnInterest = 'interest';
  static const String txnAssetPurchase = 'asset_purchase';
  static const String txnAssetSale = 'asset_sale';

  // Income Categories
  static const String incomeClientPayment = 'Client Payment';
  static const String incomeService = 'Service Income';
  static const String incomeMaintenance = 'Maintenance Income';
  static const String incomeAMC = 'AMC';
  static const String incomeSubscription = 'Subscription';
  static const String incomeCommission = 'Commission';
  static const String incomeOther = 'Other Income';
  static const String incomeRecurring = 'Recurring Income';
  static const String incomeConsulting = 'Consulting';
  static const String incomeProductSale = 'Product Sale';
  static const String incomeRoyalty = 'Royalty';
  static const String incomeInterest = 'Interest Income';
  static const String incomeDividend = 'Dividend Income';
  static const String incomeRefund = 'Refund';
  static const String incomeDiscount = 'Discount Received';

  // Income Categories List
  static const List<String> incomeCategories = [
    incomeClientPayment,
    incomeService,
    incomeMaintenance,
    incomeAMC,
    incomeSubscription,
    incomeCommission,
    incomeOther,
    incomeRecurring,
    incomeConsulting,
    incomeProductSale,
    incomeRoyalty,
    incomeInterest,
    incomeDividend,
    incomeRefund,
    incomeDiscount,
  ];

  // Expense Categories
  static const String expenseOfficeRent = 'Office Rent';
  static const String expenseElectricity = 'Electricity';
  static const String expenseInternet = 'Internet';
  static const String expenseWater = 'Water';
  static const String expenseGas = 'Gas';
  static const String expenseSalary = 'Employee Salary';
  static const String expenseBonus = 'Bonus';
  static const String expenseSupplies = 'Office Supplies';
  static const String expenseLaptop = 'Laptop Purchase';
  static const String expenseFurniture = 'Furniture';
  static const String expenseMarketing = 'Marketing';
  static const String expenseFacebookAds = 'Facebook Ads';
  static const String expenseGoogleAds = 'Google Ads';
  static const String expenseHosting = 'Hosting';
  static const String expenseDomain = 'Domain';
  static const String expenseCloud = 'Cloud';
  static const String expenseTravel = 'Travel';
  static const String expenseFuel = 'Fuel';
  static const String expenseFood = 'Food';
  static const String expenseEntertainment = 'Entertainment';
  static const String expenseLegal = 'Legal';
  static const String expenseTax = 'Tax';
  static const String expenseMaintenance = 'Maintenance';
  static const String expenseInsurance = 'Insurance';
  static const String expenseMiscellaneous = 'Miscellaneous';
  static const String expenseSoftware = 'Software Licenses';
  static const String expenseBanking = 'Banking Fees';
  static const String expenseShipping = 'Shipping';
  static const String expenseTraining = 'Training';
  static const String expenseUtilities = 'Utilities';
  static const String expenseTelephone = 'Telephone';
  static const String expenseConsulting = 'Consulting Fees';

  // Expense Categories List
  static const List<String> expenseCategories = [
    expenseOfficeRent,
    expenseElectricity,
    expenseInternet,
    expenseWater,
    expenseGas,
    expenseSalary,
    expenseBonus,
    expenseSupplies,
    expenseLaptop,
    expenseFurniture,
    expenseMarketing,
    expenseFacebookAds,
    expenseGoogleAds,
    expenseHosting,
    expenseDomain,
    expenseCloud,
    expenseTravel,
    expenseFuel,
    expenseFood,
    expenseEntertainment,
    expenseLegal,
    expenseTax,
    expenseMaintenance,
    expenseInsurance,
    expenseMiscellaneous,
    expenseSoftware,
    expenseBanking,
    expenseShipping,
    expenseTraining,
    expenseUtilities,
    expenseTelephone,
    expenseConsulting,
  ];

  // Invoice Status
  static const String invoicePaid = 'paid';
  static const String invoicePending = 'pending';
  static const String invoiceOverdue = 'overdue';
  static const String invoiceCancelled = 'cancelled';

  // Investment Types
  static const String investmentStocks = 'stocks';
  static const String investmentBonds = 'bonds';
  static const String investmentMutualFund = 'mutual_fund';
  static const String investmentRealEstate = 'real_estate';
  static const String investmentFD = 'fd';
  static const String investmentCrypto = 'crypto';
  static const String investmentPPF = 'ppf';
  static const String investmentEPF = 'epf';
  static const String investmentNPS = 'nps';
  static const String investmentGold = 'gold';
  static const String investmentSIP = 'sip';
  static const String investmentRD = 'rd';
  static const String investmentOther = 'other';

  // Investment Types List
  static const List<String> investmentTypes = [
    investmentStocks,
    investmentBonds,
    investmentMutualFund,
    investmentRealEstate,
    investmentFD,
    investmentCrypto,
    investmentPPF,
    investmentEPF,
    investmentNPS,
    investmentGold,
    investmentSIP,
    investmentRD,
    investmentOther,
  ];

  // Payment Methods
  static const String paymentCash = 'cash';
  static const String paymentBankTransfer = 'bank_transfer';
  static const String paymentCheck = 'check';
  static const String paymentCard = 'card';
  static const String paymentUPI = 'upi';
  static const String paymentOnline = 'online';
  static const String paymentOther = 'other';

  // Payment Methods List
  static const List<String> paymentMethods = [
    paymentCash,
    paymentBankTransfer,
    paymentCheck,
    paymentCard,
    paymentUPI,
    paymentOnline,
    paymentOther,
  ];

  // Recurring Periods
  static const String periodDaily = 'daily';
  static const String periodWeekly = 'weekly';
  static const String periodBiWeekly = 'bi_weekly';
  static const String periodMonthly = 'monthly';
  static const String periodQuarterly = 'quarterly';
  static const String periodHalfYearly = 'half_yearly';
  static const String periodYearly = 'yearly';

  // Recurring Periods List
  static const List<String> recurringPeriods = [
    periodDaily,
    periodWeekly,
    periodBiWeekly,
    periodMonthly,
    periodQuarterly,
    periodHalfYearly,
    periodYearly,
  ];

  // Time Periods
  static const String periodToday = 'today';
  static const String periodWeek = 'week';
  static const String periodMonth = 'month';
  static const String periodQuarter = 'quarter';
  static const String periodYear = 'year';

  // Date Formats
  static const String dateFormatDisplay = 'MMM dd, yyyy';
  static const String dateFormatAPI = 'yyyy-MM-dd';
  static const String dateFormatMonthYear = 'MMMM yyyy';
  static const String dateTimeFormatDisplay = 'MMM dd, yyyy HH:mm';

  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // File Upload Limits
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedFileTypes = [
    'pdf',
    'jpg',
    'jpeg',
    'png',
    'xlsx',
    'xls',
    'doc',
    'docx'
  ];

  // Charts
  static const int maxChartDatasets = 12;
  static const int maxChartDataPoints = 365;

  // API Timeout
  static const int apiTimeout = 30000; // 30 seconds
  static const int uploadTimeout = 120000; // 2 minutes

  // Cache Duration
  static const int cacheDuration = 300; // 5 minutes
}