require 'savon'

class Payer < ApplicationService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Savon.client(wsdl: "http://#{ENV['CREDIT_CARD_URL']}:#{ENV['CREDIT_CARD_PORT']}/ws/creditcardvalidation.wsdl")
    response = client.call(:get_credit_card_validation, message: { number: message[:credit_number_card] })
    response.body[:get_credit_card_validation_response][:issuing_network] != "Invalid Card"

    # HTTParty.post('http://localhost:8080/creditcard/verifyCreditCard',
    # :body => request_params(response_verification).to_json,
    # :headers => { 'Content-Type' => 'application/json' } )
  end
  #
  #   private
  #
  #   def request_params(response)
  #     {
  #       cc: {
  #         type: response.body[:get_credit_card_validation_response][:issuing_network],
  #         mount: message[:total],
  #         number: message[:credit_number_card]
  #       }
  #     }
  #   end
end
