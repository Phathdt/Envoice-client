class @InvoiceForm
  dataPrice : []

  constructor: ->
    @dataPrice = JSON.parse($('#product-price').val())
    @prepareProduct()
    @selectProduct()
    @selectQuanity()
    @selectVatPercent()
    @validateItem()

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

  validateItem: ->
    self = @

    shouldDisableSubmit = false

    if $('#table-product input.quantity').length == 0
      self.disableSubmit(true)
    else
      $('#table-product input.quantity').each ->
        quantity = parseInt($(@).val()) || 0
        if quantity == 0
          shouldDisableSubmit = true

      self.disableSubmit(shouldDisableSubmit)

    $('#table-product').on 'change', 'input.quantity', (e) ->
      shouldDisableSubmit = false

      $('#table-product input.quantity').each ->
        quantity = parseInt($(@).val()) || 0
        if quantity == 0
          shouldDisableSubmit = true

      if shouldDisableSubmit
        self.disableSubmit(true)
      else
        self.disableSubmit(false)

  disableSubmit: (disable) ->
    $('input[type="submit"]').prop('disabled', disable);
