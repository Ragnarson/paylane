module PayLane
  class Payment
    def initialize(options = {})
      gateway = PayLane::Gateway.new(PayLane.login, PayLane.password)
      @api = PayLane::API.new(gateway.connect)
      @options = options
    end

    def charge_card(amount)
      do_payment(amount, {'card_data' => card_data})
    end

    def direct_debit(amount)
      do_payment(amount, {'account_data' => account_data})
    end

    private

    def do_payment(amount, payment_method)
      @amount = amount
      response = @api.multi_sale(params.merge('payment_method' => payment_method))
      PayLane.logger.info("[PayLane] #{response}")
      response
    end

    protected

    def params
      {
        'customer' => customer,
        'amount' => @amount,
        'currency_code' => PayLane.currency,
        'processing_date' => "#{Date.today}",
        'product' => {
          'description' => "[#{@options[:product]}][#{Time.now.getutc}]"
        }
      }
    end

    def card_data
      {}
    end

    def account_data
      {}
    end

    def customer
      {}
    end
  end
end

