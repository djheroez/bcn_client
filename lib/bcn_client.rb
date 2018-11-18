require 'bcn_client/version'
require 'bcn_client/day_rate'
require 'bigdecimal'
require 'savon'

module BcnClient
  WSDL = 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL'

  def self.create(wsdl: WSDL, log_level: :info, log: false)
    Client.new(wsdl: wsdl, log_level: log_level, log: log)
  end

  class Client
    def initialize(wsdl: WSDL,
                   log_level: :info,
                   log: false
                  )

      @client = Savon.client(
                  wsdl: wsdl,
                  log_level: log_level,
                  pretty_print_xml: true,
                  log: log,
                  convert_request_keys_to: :camelcase
                )
    end

    def day_rate(day, month, year)
      response = @client.call(:recupera_tc_dia,
                              message: {
                                Dia: day,
                                Mes: month,
                                Ano: year
                              })
      BigDecimal.new(response.body[:recupera_tc_dia_response][:recupera_tc_dia_result])
    end

    def month_rate(month, year)
      response = @client.call(:recupera_tc_mes,
                              message: {
                                Mes: month,
                                Ano: year
                              })
      response.body[:recupera_tc_mes_response][:recupera_tc_mes_result][:detalle_tc][:tc]
              .map { |rate| DayRate.new(rate) }
    end
  end
end
