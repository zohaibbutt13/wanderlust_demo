module General
  class CurrencyConverterService
    def initialize(amount, current_currency = CENTS_CODE, desired_currency = USD_CURRENCY_CODE)
      @amount = amount
      @current_currency = current_currency
      @desired_currency = desired_currency
    end

    def call
      converted_amount = convert_to_usd
      converted_amount = currency_conversion(converted_amount) if @desired_currency != USD_CURRENCY_CODE

      converted_amount
    end

    private

    def convert_to_usd
      case @current_currency
      when CENTS_CODE
        @amount.to_f / 100
      else
        raise "Unsupported currency: #{@current_currency}"
      end
    end

    def currency_conversion(amount_in_usd)
      case @desired_currency
      when EUR_CURRENCY_CODE
        convert_usd_to_eur(amount_in_usd)
      when GBP_CURRENCY_CODE
        convert_usd_to_gbp(amount_in_usd)
      else
        raise "Unsupported conversion to #{@desired_currency}"
      end
    end

    def convert_usd_to_eur(amount_in_usd)
      amount_in_usd * 0.85
    end

    def convert_usd_to_gbp(amount_in_usd)
      amount_in_usd * 0.75
    end
  end
end
