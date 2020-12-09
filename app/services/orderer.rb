class Orderer < ApplicationService
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def call
    success = true
    order.order_products.each do |product|
      response = HTTParty.get("http://#{ENV['PRODUCT_SERVICE_URL']}:#{ENV['PRODUCT_SERVICE_PORT']}/products/#{product.produc_id}")
      transport_type = JSON.parse(response.body)['transportType']
      case transport_type
      when 'Aereo'
        HTTParty.post("http://#{ENV['SUPPLIER_SERVICE_URL']}:#{ENV['SUPPLIER_SERVICE_PORT']}/api/Supplier/ReservationFlight", body: flight_transport_params(JSON.parse(response.body), product), headers: { "Content-Type": "application/json"})
      when 'Terrestre'
        HTTParty.post("http://#{ENV['SUPPLIER_SERVICE_URL']}:#{ENV['SUPPLIER_SERVICE_PORT']}/api/Land/OrderReservationLand", body: land_transport_params(JSON.parse(response.body), product).to_json, headers: { "Content-Type": "application/json"})
      else
        success = false
      end

      loding_type = JSON.parse(response.body)['lodgingType']

      if loding_type.eql?('Hotel')
        HTTParty.post("http://#{ENV['SUPPLIER_SERVICE_URL']}:#{ENV['SUPPLIER_SERVICE_PORT']}/api/Hotel/OrderReservationHotel", body: hotel_params(JSON.parse(response.body)), headers: { "Content-Type": "application/json"})
      else
        success = false
      end
    end
    success
  end

  private

  def flight_transport_params(response, product)
    {
        "DepartureDate": response['arrivalDate'],
        "ReturnDate": response['departureDate'],
        "OriginCityDescription": response['originCity'],
        "DestinationCityDescription": response['destinationCity'],
        "PassengersNumber": product.count,
        "OneWay": "false",
        "AirlineType": 1,
        "OrderID": "2"
    }
  end

  def land_transport_params(response, product)
    {
        "NomPasajero": "Oscar Alexander",
        "ApesPasajero": "Nope Saavedra",
        "TipoDoc": "1",
        "NumDoc": "79800497",
        "fechaViaje": "2020-12-01",
        "horaViaje": "11:00AM",
        "Origen": response['originCity'],
        "Destino": response['destinationCity'],
        "OneWay": "false",
        "LandType": 1
    }
  end

  def hotel_params(response)
    {
        "fecInicio": response['arrivalDate'],
        "fecFin": response['departureDate'],
        "NombreHuesped":"Oscar Nope",
        "TienePasaporte":"1",
        "numPasaporte":"122245",
        "numDoc":"79854892",
        "Observaciones":"Requiere Parqueadero",
        "TipoHabitacion":1,
        "HotelType": 2
    }
  end
end
