require 'bigdecimal'

module BcnClient
  class DayRate
    attr_accessor :day, :month, :year, :rate, :date, :value

    def initialize(bcn_rate = nil)
      if(!bcn_rate.nil?)
        @date = bcn_rate[:fecha],
        @year = bcn_rate[:ano]
        @month = bcn_rate[:mes]
        @day = bcn_rate[:dia]
        @value = BigDecimal.new(bcn_rate[:valor])
      end
    end

    def inspect
      "DayRate { " +
        "date: #{@date}, " +
        "year: #{@year}, " +
        "month: #{@month}, " +
        "day: #{@day}, " +
        "value: " + @value.to_s('F') +
      "}"
    end
  end
end
