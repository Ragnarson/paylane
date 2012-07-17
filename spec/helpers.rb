module PublicTestAccount
  LOGIN = 'paylane_test_public'
  PASSWORD = 'p2y12n3t3st'
end

module Helpers
  def mock_api_method(connection, method)
    response = double(to_hash: yield)
    connection.should_receive(:request).with(method).and_return(response)
  end
end
