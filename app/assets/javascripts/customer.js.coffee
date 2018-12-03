$ ->
  $('.customer-button').click (e) ->
    tax_number = $('#customer_tax_number').val()
    return if tax_number.length == 0

    $.ajax
      url: Routes.search_tax_customers_path()
      type: 'POST'
      data: {tax_number: tax_number}
      dataType: 'script'
