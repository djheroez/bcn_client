# frozen_string_literal: true

module BcnClient
  class DayRate
    attr_accessor :day, :month, :year, :rate, :date, :value

    def initialize(bcn_rate = nil)
      return if bcn_rate.nil?

      @date = bcn_rate[:fecha]
      @year = bcn_rate[:ano]
      @month = bcn_rate[:mes]
      @day = bcn_rate[:dia]
      @value = BigDecimal(bcn_rate[:valor])
    end

    def inspect
      "#{self.class} " \
      "{ date: #{@date}, year: #{@year}, month: #{@month}, day: #{@day}," \
      "value: #{(@value&.to_s('F') || '')} }"
    end
  end
end
