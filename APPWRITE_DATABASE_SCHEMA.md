# Appwrite Database Schema
## Business Finance Management System ERP

### Database Configuration
- **Database ID:** your-database-id
- **Project ID:** your-project-id
- **Endpoint:** https://cloud.appwrite.io/v1

---

## Collections Structure

### 1. Users Collection
**Collection ID:** users
**Attributes:**
- `user_id` (string, required, unique) - Appwrite User ID
- `email` (string, required, unique) - User email address
- `name` (string, required) - Full name
- `role` (string, required, enum) - super_admin, owner, accountant, hr, manager, employee, read_only
- `phone` (string) - Phone number
- `avatar` (string) - Profile image URL
- `department` (string) - Department name
- `designation` (string) - Job title
- `is_active` (boolean, default: true) - Active status
- `last_login` (datetime) - Last login timestamp
- `created_at` (datetime, required) - Account creation date
- `updated_at` (datetime) - Last update timestamp

**Indexes:**
- Index on `user_id` (unique)
- Index on `email` (unique)
- Index on `role`
- Index on `is_active`

**Permissions:**
- Read: Any role with appropriate permissions
- Create: Super Admin, Owner
- Update: Super Admin, Owner, Accountant
- Delete: Super Admin only

---

### 2. Companies Collection
**Collection ID:** companies
**Attributes:**
- `company_id` (string, required, unique) - Company unique identifier
- `name` (string, required) - Company name
- `legal_name` (string, required) - Legal business name
- `registration_number` (string) - Business registration number
- `tax_id` (string) - Tax identification number
- `logo` (string) - Company logo URL
- `address` (object) - Company address
  - `street` (string)
  - `city` (string)
  - `state` (string)
  - `zip_code` (string)
  - `country` (string)
- `contact` (object) - Contact information
  - `phone` (string)
  - `email` (string)
  - `website` (string)
- `currency` (string, default: "USD") - Default currency
- `timezone` (string, default: "UTC") - Company timezone
- `fiscal_year_start` (string) - Fiscal year start month
- `fiscal_year_end` (string) - Fiscal year end month
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `company_id` (unique)
- Index on `name`

---

### 3. Transactions Collection
**Collection ID:** transactions
**Attributes:**
- `transaction_id` (string, required, unique) - Transaction unique ID
- `type` (string, required, enum) - income, expense, investment, withdrawal, transfer, bank_deposit, bank_withdraw, loan, loan_payment, tax, refund, adjustment, interest, asset_purchase, asset_sale
- `category` (string, required) - Transaction category
- `subcategory` (string) - Subcategory
- `amount` (number, required) - Transaction amount
- `currency` (string, required) - Currency code
- `description` (string) - Transaction description
- `reference_number` (string) - Reference/invoice number
- `date` (datetime, required) - Transaction date
- `status` (string, required) - pending, completed, cancelled, failed
- `payment_method` (string) - cash, bank, card, transfer, other
- `bank_account_id` (string) - Related bank account
- `client_id` (string) - Related client (if applicable)
- `vendor_id` (string) - Related vendor (if applicable)
- `invoice_id` (string) - Related invoice (if applicable)
- `employee_id` (string) - Related employee (if applicable)
- `asset_id` (string) - Related asset (if applicable)
- `recurring_id` (string) - Parent recurring transaction
- `attachments` (array) - File attachment URLs
- `tags` (array) - Transaction tags
- `created_by` (string, required) - User ID who created
- `approved_by` (string) - User ID who approved
- `approved_at` (datetime) - Approval timestamp
- `reconciled` (boolean, default: false) - Bank reconciliation status
- `reconciled_at` (datetime) - Reconciliation timestamp
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `transaction_id` (unique)
- Index on `type`
- Index on `date` (descending)
- Index on `status`
- Index on `category`
- Index on `client_id`
- Index on `bank_account_id`

---

### 4. Categories Collection
**Collection ID:** categories
**Attributes:**
- `category_id` (string, required, unique) - Category unique ID
- `type` (string, required, enum) - income, expense, investment, transfer
- `name` (string, required) - Category name
- `description` (string) - Category description
- `parent_id` (string) - Parent category ID
- `icon` (string) - Icon identifier
- `color` (string) - Color code for UI
- `budget` (number) - Monthly budget amount
- `is_active` (boolean, default: true)
- `is_system` (boolean, default: false) - System default category
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `category_id` (unique)
- Index on `type` and `name`

---

### 5. Clients Collection
**Collection ID:** clients
**Attributes:**
- `client_id` (string, required, unique) - Client unique ID
- `name` (string, required) - Client/company name
- `contact_person` (string) - Primary contact person
- `email` (string, required) - Email address
- `phone` (string) - Phone number
- `address` (object) - Client address
- `tax_id` (string) - Client tax ID
- `industry` (string) - Industry sector
- `website` (string) - Website URL
- `status` (string, default: "active") - active, inactive, archived
- `credit_limit` (number) - Credit limit amount
- `payment_terms` (string) - Payment terms description
- `notes` (string) - Additional notes
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `client_id` (unique)
- Index on `email` (unique)
- Index on `status`

---

### 6. Vendors Collection
**Collection ID:** vendors
**Attributes:**
- `vendor_id` (string, required, unique) - Vendor unique ID
- `name` (string, required) - Vendor/company name
- `contact_person` (string) - Primary contact person
- `email` (string, required) - Email address
- `phone` (string) - Phone number
- `address` (object) - Vendor address
- `tax_id` (string) - Vendor tax ID
- `category` (string) - Vendor category
- `payment_terms` (string) - Payment terms
- `bank_details` (object) - Bank account details
- `status` (string, default: "active") - active, inactive, archived
- `credit_period` (number) - Credit period in days
- `notes` (string) - Additional notes
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `vendor_id` (unique)
- Index on `email` (unique)
- Index on `status`

---

### 7. Employees Collection
**Collection ID:** employees
**Attributes:**
- `employee_id` (string, required, unique) - Employee unique ID
- `user_id` (string, unique) - Linked user account
- `name` (string, required) - Full name
- `email` (string, required, unique) - Email address
- `phone` (string) - Phone number
- `department` (string, required) - Department name
- `designation` (string, required) - Job title
- `joining_date` (datetime, required) - Date of joining
- `salary` (number, required) - Monthly salary
- `bank_account` (object) - Bank account details
- `address` (object) - Employee address
- `emergency_contact` (object) - Emergency contact details
- `status` (string, default: "active") - active, resigned, terminated
- `employment_type` (string) - full_time, part_time, contract, intern
- `documents` (array) - Document URLs
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `employee_id` (unique)
- Index on `email` (unique)
- Index on `department`
- Index on `status`

---

### 8. Invoices Collection
**Collection ID:** invoices
**Attributes:**
- `invoice_id` (string, required, unique) - Invoice unique ID
- `invoice_number` (string, required, unique) - Invoice number
- `client_id` (string, required) - Client reference
- `project_id` (string) - Related project
- `type` (string, required, enum) - invoice, quotation, estimate
- `status` (string, required) - draft, sent, paid, pending, overdue, cancelled
- `issue_date` (datetime, required) - Invoice issue date
- `due_date` (datetime, required) - Payment due date
- `subtotal` (number, required) - Subtotal amount
- `tax_amount` (number, default: 0) - Tax amount
- `discount_amount` (number, default: 0) - Discount amount
- `total_amount` (number, required) - Total amount
- `paid_amount` (number, default: 0) - Amount paid
- `due_amount` (number, required) - Amount due
- `items` (array, required) - Invoice items
  - `description` (string)
  - `quantity` (number)
  - `unit_price` (number)
  - `tax_rate` (number)
  - `discount` (number)
  - `total` (number)
- `notes` (string) - Invoice notes
- `terms` (string) - Payment terms
- `currency` (string, required) - Currency code
- `recurring` (boolean, default: false) - Is recurring invoice
- `recurring_pattern` (string) - Recurring pattern (monthly, quarterly, etc.)
- `attachments` (array) - Attachment URLs
- `created_by` (string, required) - User ID
- `sent_at` (datetime) - Sent timestamp
- `paid_at` (datetime) - Payment timestamp
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `invoice_id` (unique)
- Index on `invoice_number` (unique)
- Index on `client_id`
- Index on `status`
- Index on `due_date`
- Index on `issue_date` (descending)

---

### 9. Loans Collection
**Collection ID:** loans
**Attributes:**
- `loan_id` (string, required, unique) - Loan unique ID
- `type` (string, required, enum) - borrowing, lending
- `lender_id` (string) - Lender reference
- `borrower_id` (string) - Borrower reference
- `principal_amount` (number, required) - Principal amount
- `interest_rate` (number, required) - Annual interest rate (%)
- `emi_amount` (number) - Monthly EMI amount
- `tenure_months` (number, required) - Loan tenure in months
- `start_date` (datetime, required) - Loan start date
- `end_date` (datetime, required) - Loan end date
- `status` (string, required) - active, paid, defaulted, closed
- `outstanding_amount` (number, required) - Current outstanding amount
- `paid_amount` (number, default: 0) - Total amount paid
- `purpose` (string) - Loan purpose
- `collateral` (string) - Collateral details
- `documents` (array) - Document URLs
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `loan_id` (unique)
- Index on `status`
- Index on `start_date` (descending)

---

### 10. Assets Collection
**Collection ID:** assets
**Attributes:**
- `asset_id` (string, required, unique) - Asset unique ID
- `name` (string, required) - Asset name
- `type` (string, required) - Asset type (laptop, desktop, vehicle, furniture, etc.)
- `category` (string, required) - Asset category
- `serial_number` (string, unique) - Serial number
- `purchase_date` (datetime, required) - Purchase date
- `purchase_cost` (number, required) - Purchase cost
- `current_value` (number, required) - Current value
- `depreciation_rate` (number) - Annual depreciation rate (%)
- `accumulated_depreciation` (number, default: 0) - Total depreciation
- `net_book_value` (number, required) - Net book value
- `useful_life_years` (number, required) - Useful life in years
- `location` (string) - Asset location
- `assigned_to` (string) - Assigned employee ID
- `status` (string, required) - active, sold, disposed, maintenance
- `maintenance_records` (array) - Maintenance history
- `documents` (array) - Document URLs
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `asset_id` (unique)
- Index on `serial_number` (unique)
- Index on `type`
- Index on `status`

---

### 11. Bank Accounts Collection
**Collection ID:** bank_accounts
**Attributes:**
- `account_id` (string, required, unique) - Account unique ID
- `account_name` (string, required) - Account holder name
- `bank_name` (string, required) - Bank name
- `account_number` (string, required, unique) - Account number
- `account_type` (string, required) - savings, current, fixed_deposit, loan
- `currency` (string, required) - Account currency
- `current_balance` (number, required) - Current balance
- `available_balance` (number, required) - Available balance
- `bank_address` (string) - Bank branch address
- `ifsc_code` (string) - IFSC/SWIFT code
- `micr_code` (string) - MICR code
- `is_primary` (boolean, default: false) - Primary account flag
- `is_active` (boolean, default: true) - Active status
- `last_reconciled` (datetime) - Last reconciliation date
- `opening_balance` (number) - Opening balance
- `notes` (string) - Additional notes
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `account_id` (unique)
- Index on `account_number` (unique)
- Index on `is_primary`

---

### 12. Investments Collection
**Collection ID:** investments
**Attributes:**
- `investment_id` (string, required, unique) - Investment unique ID
- `type` (string, required, enum) - owner, partner, investor, share_capital
- `investor_id` (string, required) - Investor reference
- `amount` (number, required) - Investment amount
- `currency` (string, required) - Currency code
- `date` (datetime, required) - Investment date
- `roi_percentage` (number) - Expected ROI percentage
- `status` (string, required) - active, withdrawn, matured
- `current_value` (number, required) - Current value
- `profit_loss` (number) - Profit/Loss amount
- `documents` (array) - Investment document URLs
- `notes` (string) - Investment notes
- `withdrawal_date` (datetime) - Withdrawal date
- `withdrawal_amount` (number) - Withdrawal amount
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `investment_id` (unique)
- Index on `investor_id`
- Index on `type`
- Index on `date` (descending)

---

### 13. Notifications Collection
**Collection ID:** notifications
**Attributes:**
- `notification_id` (string, required, unique) - Notification unique ID
- `user_id` (string, required) - Target user ID
- `type` (string, required) - salary_due, invoice_due, payment_reminder, etc.
- `title` (string, required) - Notification title
- `message` (string, required) - Notification message
- `priority` (string, default: "normal") - low, normal, high, urgent
- `is_read` (boolean, default: false) - Read status
- `action_url` (string) - Action URL
- `action_type` (string) - invoice, payment, report, etc.
- `action_id` (string) - Related entity ID
- `created_at` (datetime, required)
- `read_at` (datetime) - Read timestamp

**Indexes:**
- Index on `notification_id` (unique)
- Index on `user_id`
- Index on `is_read`
- Index on `created_at` (descending)

---

### 14. Settings Collection
**Collection ID:** settings
**Attributes:**
- `setting_id` (string, required, unique) - Setting unique ID
- `module` (string, required) - Module name
- `key` (string, required) - Setting key
- `value` (string, required) - Setting value
- `type` (string, required) - string, number, boolean, json
- `description` (string) - Setting description
- `is_public` (boolean, default: false) - Public access
- `created_at` (datetime, required)
- `updated_at` (datetime)

**Indexes:**
- Index on `setting_id` (unique)
- Index on `module` and `key` (unique)

---

## Storage Buckets

### 1. Documents Bucket
**Bucket ID:** documents
**File Types:** PDF, DOC, DOCX, XLS, XLSX
**Max Size:** 10MB per file
**Permissions:** Read/Write based on user roles

### 2. Images Bucket
**Bucket ID:** images
**File Types:** JPG, JPEG, PNG, GIF
**Max Size:** 5MB per file
**Permissions:** Read/Write based on user roles

### 3. Avatars Bucket
**Bucket ID:** avatars
**File Types:** JPG, JPEG, PNG
**Max Size:** 2MB per file
**Permissions:** Read public, Write by owner

### 4. Reports Bucket
**Bucket ID:** reports
**File Types:** PDF
**Max Size:** 20MB per file
**Permissions:** Based on report access

---

## Realtime Subscriptions

### Subscriptions to implement:
1. **Transactions** - Subscribe to new/updated transactions
2. **Notifications** - Subscribe to user notifications
3. **Invoices** - Subscribe to invoice status changes
4. **Bank Accounts** - Subscribe to balance updates
5. **Dashboard Data** - Subscribe to dashboard KPI changes

---

## Security & Permissions

### Role-based Access Control:
- **Super Admin:** Full access to all resources
- **Owner:** Full access except user management
- **Accountant:** Read/Write transactions, reports, invoices
- **HR:** Employee management, salary payments
- **Manager:** Read access to reports, write to assigned modules
- **Employee:** Read access to assigned data only
- **Read Only:** Read access only

### Document Security:
- Financial documents encrypted at rest
- Audit logging for all financial transactions
- Role-based file access permissions
- Automatic backup of critical documents