class @InvoiceForm
  dataPrice : []
  dataCustomer : []

  constructor: ->
    @dataPrice = JSON.parse($('#product-price').val())
    @dataCustomer = JSON.parse($('#customer-company').val())
    @prepareCustomer()
    @prepareProduct()
    @selectCustomer()
    @selectProduct()
    @selectQuanity()
    @selectVatPercent()

  selectProduct: ->
    self = @

    $('#table-product').on 'change', '.product_id', (e) ->
      product_id = parseInt($(this).val())
      products = self.dataPrice.filter (x) -> x.id == product_id
      product = products[0]
      quantity = parseInt($(@).parent().parent().parent().find('.quantity').val())

      $(@).parent().parent().parent().find('.unit').val(product.unit)
      $(@).parent().parent().parent().find('.price').val(product.price)
      $(@).parent().parent().parent().find('.total').val(product.price * quantity)

      self.triggerCalcu()

  selectQuanity: ->
    self = @
    $('#table-product').on 'change', 'input.quantity', (e) ->
      quantity = parseInt($(@).val()) || 0
      product_id = parseInt($(@).parent().parent().parent().find('.product_id').val()) || 0
      products = self.dataPrice.filter (x) -> x.id == product_id

      that = @
      if products
        product = products[0]
        total = product.price * quantity
        $(that).parent().parent().parent().find('.total').val(total)

      self.triggerCalcu()

  selectVatPercent: ->
    self = @
    $('.form_invoice').on 'change', '.vat_percent', ->
      vat_percent = parseInt($(this).val())

      price_total = 0

      $('#table-product .total').each ->
        total = parseInt($(this).val())
        price_total += total

      $('.price-total').val(price_total)
      $('.vat-price').val(price_total * vat_percent / 100)
      $('.paid-total').val(price_total - price_total * vat_percent / 100)

  triggerCalcu: ->
    vat_percent = parseInt($('.vat_percent').val())

    price_total = 0

    $('#table-product .total').each ->
      total = parseInt($(this).val())
      price_total += total

    $('.price-total').val(price_total)
    $('.vat-price').val(price_total * vat_percent / 100)
    $('.paid-total').val(price_total - price_total * vat_percent / 100)

  selectCustomer: ->
    self = @

    $('.customer-invoice').on 'change', '.customer-id', ->
      customer_id = parseInt($(this).val())
      customers = self.dataCustomer.filter (x) -> x.id == customer_id
      customer = customers[0]

      $('.customer-invoice .address').val(customer.address)
      $('.customer-invoice .phone_number').val(customer.phone_number)
      $('.customer-invoice .email').val(customer.email)

  prepareCustomer: ->
    return if $('.customer-invoice .customer-id').val() == ''
    customer_id = parseInt($('.customer-invoice .customer-id').val())

    customers = @dataCustomer.filter (x) -> x.id == customer_id
    customer = customers[0]

    $('.customer-invoice .address').val(customer.address)
    $('.customer-invoice .phone_number').val(customer.phone_number)
    $('.customer-invoice .email').val(customer.email)

  prepareProduct: ->
    self = @

    $('#table-product .product_id').each ->
      product_id = parseInt($(this).val())
      products = self.dataPrice.filter (x) -> x.id == product_id
      product = products[0]
      quantity = parseInt($(@).parent().parent().parent().find('.quantity').val())

      $(@).parent().parent().parent().find('.unit').val(product.unit)
      $(@).parent().parent().parent().find('.price').val(product.price)
      $(@).parent().parent().parent().find('.total').val(product.price * quantity)

      self.triggerCalcu()
