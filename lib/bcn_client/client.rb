# frozen_string_literal: true

module BcnClient
  DEFAULTS = {
    wsdl: 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL',
    log_level: :info,
    log: false,
    pretty_print_xml: true,
    ssl_verify_mode: :peer,
    convert_request_keys_to: :camelcase,
  }.freeze

  def self.create(options = {})
    Client.new(options)
  end

  class Client
    def initialize(options = {})
      @client = Savon.client(DEFAULTS.merge(options))
    end

    def day_rate(day = nil, month = nil, year = nil)
      today = DateTime.now
      response = @client.call(:recupera_tc_dia,
                              message: {
                                Dia: day || today.day,
                                Mes: month || today.month,
                                Ano: year || today.year
                              })
      dia_response = response.body&.[](:recupera_tc_dia_response)
      return nil if dia_response.nil?

      BigDecimal(dia_response&.[](:recupera_tc_dia_result))
    end

    def month_rate(month = nil, year = nil)
      today = DateTime.now
      response = @client.call(:recupera_tc_mes,
                              message: {
                                Mes: month || today.month,
                                Ano: year || today.year
                              })
      mes_response = response.body&.[](:recupera_tc_mes_response)
      return nil if mes_response.nil?

      mes_response&.[](:recupera_tc_mes_result)&.[](:detalle_tc)&.[](:tc)
                  &.map { |rate| DayRate.new(rate) }
    end
  end
end
