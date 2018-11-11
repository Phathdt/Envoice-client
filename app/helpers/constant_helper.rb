module ConstantHelper
  URL_HELPERS = Rails.application.routes.url_helpers

  DASHBOARD_CUSTOMER_SIDEBAR = [
    ['dashboard', URL_HELPERS.root_path(locale: I18n.locale)]
  ].freeze

  COMPANY_SIDEBAR = [
    ['manage_user', URL_HELPERS.owner_users_path(locale: I18n.locale)]
  ].freeze

  PRODUCT_SIDEBAR = [
    ['list_product', URL_HELPERS.products_path(locale: I18n.locale)]
  ].freeze

  INVOICE_STAFF_SIDEBAR = [
    ['list_invoice', URL_HELPERS.invoices_path(locale: I18n.locale)]
  ].freeze

  INVOICE_OWNER_SIDEBAR = [
    ['list_invoice', URL_HELPERS.invoices_path(locale: I18n.locale)],
    ['new_invoice', URL_HELPERS.new_invoice_path(locale: I18n.locale)],
  ].freeze

  CUSTOMER_SIDEBAR = [
    ['list_customer', URL_HELPERS.customers_path(locale: I18n.locale)],
    ['new_customer', URL_HELPERS.new_customer_path(locale: I18n.locale)],
  ].freeze
end
