# frozen_string_literal: true

module ValidatesCpfCnpj
  module Cnpj
    WEIGHTS = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2].freeze

    def self.valid?(value)
      local_value = value.upcase.gsub(/[^0-9A-Z]/, '')

      return false unless local_value.size == 14

      digit = local_value.slice(-2, 2)

      control = []
      factor = 0
      2.times do |i|
        sum = 0
        12.times do |j|
          sum += (local_value.slice(j, 1).ord - 48) * WEIGHTS[j + 1 - i]
        end
        sum += factor * WEIGHTS[-1] if i == 1
        factor = 11 - (sum % 11)
        factor = 0 if factor > 9
        control << factor.to_s
      end

      control.join == digit
    end
  end
end
