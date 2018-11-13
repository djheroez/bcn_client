require 'bigdecimal'

module BcnClient
  class TasaDia
    attr_accessor :dia, :mes, :anio, :tasa, :fecha, :valor

    def initialize(tasa_bcn=nil)
      if(!tasa_bcn.nil?)
        @fecha = tasa_bcn[:fecha],
        @anio = tasa_bcn[:ano]
        @mes = tasa_bcn[:mes]
        @dia = tasa_bcn[:dia]
        @valor = BigDecimal.new(tasa_bcn[:valor])
      end
    end

    def inspect
      "TasaDia { " +
        "fecha: #{@fecha}, " +
        "anio: #{@anio}, " +
        "mes: #{@mes}, " +
        "dia: #{@dia}, " +
        "valor: " + @valor.to_s('F') +
      "}"
    end
  end
end
