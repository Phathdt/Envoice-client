$ ->
  $('#table-product').on 'cocoon:after-remove', ->
    invoice = new InvoiceForm
    invoice.triggerCalcu()
