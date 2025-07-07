module General
  class CurrencyConverterService
    def initialize(amount, current_currency = CENTS_CODE, desired_currency = USD_CURRENCY_CODE)
      @amount = amount
      @current_currency = current_currency
      @desired_currency = desired_currency
    end

    def call
      converted_amount = convert_to_usd
      converted_amount = currecny_conversion(converted_amount) if @desired_currency != USD_CURRENCY_CODE

      converted_amount
    end

    private

    def currecny_conversion(converted_amount)
      # We can convert usd to any other currency using APIs at this point
      converted_amount
    end

    def convert_to_usd
      case @current_currency
      when CENTS_CODE
        @amount.to_f / 100
      end
    end
  end
end
