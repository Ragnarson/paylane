require 'minitest/autorun'
require 'mocha'
require 'paylane'

class TestGateway < MiniTest::Unit::TestCase
  def setup
    @gateway = PayLane::Gateway.new('paylane_test_public', 'p2y12n3t3st')
  end

  def test_authentication
    Savon.expects(:client)
    @gateway.connect
  end

  def test_wsdl_location
    assert_equal 'https://direct.paylane.com/wsdl/production/Direct.wsdl', @gateway.wsdl_location
  end

  def test_authorization_header
    assert_equal "Basic cGF5bGFuZV90ZXN0X3B1YmxpYzpwMnkxMm4zdDNzdA==\n", @gateway.authorization_header
  end

  def test_encoded_credentails
    assert_equal "cGF5bGFuZV90ZXN0X3B1YmxpYzpwMnkxMm4zdDNzdA==\n", @gateway.encoded_credentails
  end

  def test_credentials
    assert_equal 'paylane_test_public:p2y12n3t3st', @gateway.credentials
  end
end

