module PublicTestAccount
  LOGIN = 'test'
  PASSWORD = 'test'
end

module Helpers
  def mock_api_method(connection, method)
    response = double(to_hash: yield)
    connection.should_receive(:request).with(method).and_return(response)
  end
end
