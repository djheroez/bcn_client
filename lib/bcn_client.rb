require 'bcn_client/version'
require 'bigdecimal'
require 'savon'
require 'bcn_client/tasa_dia'

module BcnClient
  class Client
    def initialize(
              wsdl = 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL',
              log_level = :info,
              log = false
            )
      @client = Savon.client(
                  wsdl: wsdl,
                  log_level: log_level,
                  pretty_print_xml: true,
                  log: log,
                  convert_request_keys_to: :camelcase
                )
    end

    def obtiene_tasa_dia(dia, mes, anio)
      response = @client.call(:recupera_tc_dia,
                              message: {
                                Dia: dia,
                                Mes: mes,
                                Ano: anio
                              })
      BigDecimal.new(response.body[:recupera_tc_dia_response][:recupera_tc_dia_result])
    end

    def obtiene_tasa_mes(mes, anio)
      response = @client.call(:recupera_tc_mes,
                              message: {
                                Mes: mes,
                                Ano:  anio
                              })
      response.body[:recupera_tc_mes_response][:recupera_tc_mes_result][:detalle_tc][:tc]
              .map { |tasa| TasaDia.new(tasa) }
    end
  end
end
