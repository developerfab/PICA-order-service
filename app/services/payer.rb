require 'savon'

class Payer < ApplicationService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    if message[:payment_method] == 'credit1'
      client = Savon.client(wsdl: 'http://localhost:8090/ws/creditcardvalidation.wsdl')
      response = client.call(:get_credit_card_validation, message: { number: message[:credit_number_card] })
      if response.body[:get_credit_card_validation_response][:issuing_network] == "Invalid Card"
        return false
      else
        return true
      end
    else
    end
  end
end
