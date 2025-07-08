require 'rails_helper'

RSpec.describe General::CurrencyConverterService, type: :service do
  let(:cents_amount) { 10000 }
  let(:usd_to_eur_rate) { 0.85 }
  let(:usd_to_gbp_rate) { 0.75 }

  describe '#call' do
    context 'when converting from cents to USD' do
      it 'converts cents to USD correctly' do
        service = General::CurrencyConverterService.new(cents_amount, CENTS_CODE, USD_CURRENCY_CODE)

        result = service.call

        expect(result).to eq(100.0)
      end
    end

    context 'when converting from cents to EUR' do
      it 'converts cents to EUR correctly' do
        service = General::CurrencyConverterService.new(cents_amount, CENTS_CODE, EUR_CURRENCY_CODE)

        result = service.call

        expect(result).to eq(100.0 * usd_to_eur_rate)
      end
    end

    context 'when converting from cents to GBP' do
      it 'converts cents to GBP correctly' do
        service = General::CurrencyConverterService.new(cents_amount, CENTS_CODE, GBP_CURRENCY_CODE)

        result = service.call

        expect(result).to eq(100.0 * usd_to_gbp_rate)
      end
    end

    context 'when an unsupported current currency is provided' do
      it 'raises an exception' do
        service = General::CurrencyConverterService.new(cents_amount, 'unsupported_currency', USD_CURRENCY_CODE)

        expect { service.call }.to raise_error("Unsupported currency: unsupported_currency")
      end
    end

    context 'when an unsupported desired currency is provided' do
      it 'raises an exception' do
        service = General::CurrencyConverterService.new(cents_amount, CENTS_CODE, 'unsupported_currency')

        expect { service.call }.to raise_error("Unsupported conversion to unsupported_currency")
      end
    end
  end
end
