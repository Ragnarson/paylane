module PayLane
  class RecurringPayment
    def initialize(previous_sale_id, options = {})
      gateway = PayLane::Gateway.new(PayLane.login, PayLane.password)
      @api = PayLane::API.new(gateway.connect)
      @previous_sale_id = previous_sale_id
      @options = options
    end

    def charge_card(amount)
      @amount = amount
      response = @api.resale(params)
      PayLane.logger.info("[PayLane] #{response}")
      response
    end

    protected

    def params
      {
        'id_sale' => @previous_sale_id,
        'amount' => @amount,
        'currency' => PayLane.currency,
        'description' => "[#{@options[:product]}][#{Time.now.getutc}]"
      }
    end
  end
end
