# $company =
#   begin
#     Company.first
#   rescue ActiveRecord::NoDatabaseError => exception
#     nil
#   rescue ActiveRecord::StatementInvalid => exception
#     nil
#   end

ALERT_TYPE = {
  'alert' => 'warning',
  'notice' => 'info',
  'success' => 'success'
}.freeze

ALERT_ICON = {
  'alert' => 'ni-support-16',
  'notice' => 'ni-bell-55',
  'success' => 'ni-like-2'
}.freeze

PAYMENT_METHOD = {
  0 => 'TM/CK',
  1 => 'Thanh toán tiền mặt',
  2 => 'Thanh toán chuyển khoản',
  3 => 'Thanh toán thẻ tín dụng',
  4 => 'Thanh toán bù trừ'
}
