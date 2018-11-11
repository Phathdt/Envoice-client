module ApplicationHelper
  def percent_select
    (0..20).map { |t| [t, t]}
  end

  def payment_options
    [
      'TM/CK', 'Thanh toán tiền mặt', 'Thanh toán chuyển khoản', 'Thanh toán thẻ tín dụng', 'Thanh toán bù trừ'
    ].map.with_index { |t, index| [t, index]}

  end

end
