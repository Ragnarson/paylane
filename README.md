# Paylane [![Build Status](https://travis-ci.org/shellycloud/paylane.png)](https://travis-ci.org/shellycloud/paylane) [![Code Climate](https://codeclimate.com/github/shellycloud/paylane.png)](https://codeclimate.com/github/shellycloud/paylane)

Ruby client for [PayLane](http://www.paylane.com) payments.

## Installation

    $ gem install paylane

or

    gem 'paylane'

## Usage - API

Start from create a client for API.

    gateway = PayLane::Gateway.new('login', 'password')
    client = PayLane::API.new(gateway.connect)

Now all methods from [original API](http://devzone.paylane.com/wp-content/uploads/2012/05/paylane_direct_system.pdf) are available in the client object.

    params = {
      "payment_method" => {
        "card_data" => {
          "card_number" => 4111111111111111,
          "card_code" => 123,
          "expiration_month" => 12,
          "expiration_year" => 2020,
          "name_on_card" => "John Smith"
          }
        },
      "customer" => {
        "name" => "John Smith",
        "email" => "johnsmith@example.com",
        "ip" => "127.0.0.1",
        "address" => {
          "street_house" => "1st Avenue",
          "city" => "Lodz",
          "state" => "Lodz",
          "zip" => "00-000",
          "country_code" => "PL"
        }
      },
      "amount" => 9.99,
      "currency_code" => "EUR",
      "product" => {
        "description" => "paylane_api_test"
      }
    }

    client.multi_sale(params) #=> {ok: {id_sale: "2772323"}, data: {fraud_score: "8.76"}}

If something went wrong `PayLane::ConnectionError` error will be raised.

## Usage - custom methods

Gem provides custom methods to simplify implementation of payments in your app.

### Configuration

Firstly you need to set up credential settings. For Rails put it in initializer `config/initializers/paylane.rb`.

    PayLane.login = 'login'
    PayLane.password = 'password'

Besides `login` and `password` you can also set `currency` ('EUR' by default) and `logger`.

### Usage

Inherit your class from `PayLane::Payment` and overload `card_data` (or `account_data`) and `customer` methods. This is how it should looks for `params` from the previous example.

    class Payment < PayLane::Payment
      def initialize(params, options = {})
        super(options)
        @params = params
      end

      def card_data
        params[:payment_method][:card_data]
      end

      def customer
        params[:customer]
      end
    end

    payment = Payment.new(params, product: 'Additional pylon')
    payment.charge_card(9.99) #=> {ok: {id_sale: "2772323"}, data: {fraud_score: "8.76"}}

It works similar for recurring payments

    class RecurringPayment < PayLane::RecurringPayment
    end

    recurring_payment = RecurringPayment.new(2772323, product: 'Subscription')
    recurring_payment.charge_card(30.00) #=> {ok: {id_sale: "3131151"}, data: {fraud_score: "7.00"}}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

