EU = [
  'Austria', 'Belgium', 'Bulgaria', 'Cyprus', 'Croatia', 'Czech Republic',
  'Denmark', 'Estonia', 'France', 'Monaco', 'Greece', # 'Germany',
  'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg',
  'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia',
  'Slovenia', 'Spain', 'Sweden', 'United Kingdom', 'Isle of Man'
]

DonationForm = (form) ->
  @form = form

  country = $('#donation_country')
  city    = $('#donation_city')

  if country.length > 0
    $.getJSON '/geo_ip.json', (data) =>
      city.val(data.city)            if city.val() == ''
      country.val(data.country_name) if country.val() == ''
      @setupVAT country.val()

  if $('#vat').length > 0
    country.change =>
      @setupVAT country.val()
    $('#donation_add_vat').change ->
      $('#vat_note').toggle($(this).val() == 'true')
    @setupVAT country.val()

  form.submit =>
    # if !$('#user_stripe_card_token').val()
    #   @processCard()
    #   false
    # else
    #   @disable('Submitting ...')
    #   true
    @disable('Submitting ...')
    true

$.extend DonationForm.prototype,
  toggleSection: (name, onoff) ->
    $("#{name} #vat_note").toggle(onoff)
    $("#{name}").toggle(onoff)
    if onoff
      $("#{name} .required input").attr('required', 'required')
    else
      $("#{name} .required input").removeAttr('required')

  setupVAT: (country) ->
    $("#donation_add_vat").val((country == 'Germany').toString())
    @toggleSection "#vat-germany", country == 'Germany'
    @toggleSection '#vat', EU.indexOf(country) > -1

  # processCard: ->
  #   @disable('Validating your credit card ...')
  #   card =
  #     name: $('#donation_card_name').val()
  #     number: $('#donation_card_number').val()
  #     cvc: $('#donation_card_cvc').val()
  #     expMonth: $('#card_month').val()
  #     expYear: $('#card_year').val()
  #   Stripe.createToken(card, @handleStripeResponse.bind(@))

  # handleStripeResponse: (status, response) ->
  #   if status == 200
  #     @disable('Submitting ...')
  #     $('#user_stripe_card_token').val(response.id)
  #     @form[0].submit()
  #   else
  #     @enable()
  #     $('#stripe_error').text(response.error.message)

  disable: (message)->
    $('input[type=submit]').attr('disabled', true)
    $('.cancel').hide()
    $('.message').html(message).show()

  enable: ->
    $('input[type=submit]').attr('disabled', false)
    $('.cancel').show()
    $('.message').hide()

$.fn.donationForm = ->
  new DonationForm(this)

$(document).ready ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  $('#new_donation').donationForm()

  # $('.hint').closest('.input').find('input, textarea').tipsy
  #   gravity: 'w'
  #   offset: 5
  #   delayIn: 100
  #   title: ->
  #     $(this).parent().find('.hint').html()
