module PayLane
  class Payment
    def initialize(options = {})
      gateway = Gateway.new(PayLane.login, PayLane.password)
      @api = API.new(gateway.connect)
      @options = options
      @product = Product.new @options[:product]
    end

    def charge_card(amount)
      do_payment(amount, {'card_data' => card_data})
    end

    def direct_debit(amount)
      do_payment(amount, {'account_data' => account_data})
    end

    protected

    def params
      {
        'customer' => customer,
        'amount' => @amount,
        'currency_code' => PayLane.currency,
        'processing_date' => "#{Date.today}",
        'product' => {
          'description' => @product.description
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

    private

    def do_payment(amount, payment_method)
      @amount = amount
      response = @api.multi_sale(params.merge('payment_method' => payment_method))
      PayLane.logger.info("[PayLane] #{response}")
      response
    end
  end
end

