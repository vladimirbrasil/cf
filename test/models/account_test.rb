require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test "should not save account without refresh_token" do
    account = Account.new(provider: 'any', uid: 'any')
    assert_not account.save, "Shouldn't have created account witohut token_refresh"
  end
  
end
