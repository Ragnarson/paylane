module PayLane
  class Customer
    def self.authorize(payment_data)
      new(payment_data).tap do |customer|
        customer.charge_card(1.00) if payment_data.has_key?(:card_number)
        customer.direct_debit(1.00) if payment_data.has_key?(:account_number)
      end
    end

    def initialize(payment_data)
      gateway = PayLane::Gateway.new(PayLane::Configuration.login, PayLane::Configuration.password)
      @api = PayLane::API.new(gateway.connect)
      @payment_data = payment_data
    end

    def charge_card(amount)
      @amount = amount
      @api.multi_sale(params.merge('payment_method' => {'card_data' => card_data}))
    end

    def direct_debit(amount)
      @amount = amount
      @api.multi_sale(params.merge('payment_method' => {'account_data' => account_data}))
    end

    private

    def params
      { 'customer' => customer_data,
        'amount' => @amount,
        'currency_code' => PayLane::Configuration.currency,
        'processing_date' => "#{Date.today}",
        'product' => {'description' => "nazwa appki + timestamp"} }
    end

    def card_data
      { 'card_number' => @payment_data[:card_number],
        'card_code' => @payment_data[:card_code],
        'expiration_month' => @payment_data[:expiration_month],
        'expiration_year' => @payment_data[:expiration_year],
        'name_on_card' => @payment_data[:name_on_card] }
    end

    def account_data
      { 'account_country' => @payment_data[:account_country],
        'bank_code' => @payment_data[:bank_code],
        'account_number' => @payment_data[:account_number],
        'account_holder' => @payment_data[:account_holder] }
    end

    def customer_data
      { 'name' => 'John Smith',
        'email' => 'johnsmith@example.com',
        'ip' => '77.237.22.32',
        'address' => {
          'street_house' => '1st Avenue',
          'city' => 'Lodz',
          'state' => 'Lodz',
          'zip' => '00-000',
          'country_code' => 'PL' }}
    end
  end
end
