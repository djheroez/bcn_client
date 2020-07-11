module BcnClient
  DEFAULTS = {
    wsdl: 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL',
    log_level: :info,
    log: false,
    pretty_print_xml: true,
    ssl_verify_mode: :peer,
    convert_request_keys_to: :camelcase,
  }.freeze

  def self.create(options)
    Client.new(options)
  end

  class Client

    def initialize(options)
      @client = Savon.client(DEFAULTS.merge(options))
    end

    def day_rate(*args)
      if args.size == 0
        today = DateTime.now
        day, month, year = today.day, today.month, today.year
      elsif args.size == 3
        day, month, year = args
      else
        raise ArgumentError.new("Wrong number of arguments")
      end
      response = @client.call(:recupera_tc_dia,
                              message: {
                                Dia: day,
                                Mes: month,
                                Ano: year
                              })
      BigDecimal(response.body[:recupera_tc_dia_response][:recupera_tc_dia_result])
    end

    def month_rate(*args)
      if args.size == 0
        today = DateTime.now
        month, year = today.month, today.year
      elsif args.size == 2
        month, year = args
      else
        raise ArgumentError.new("Wrong number of arguments")
      end

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
