  require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest

  test "login indication when not logged in" do
    @current_user = nil
    https!
    get '/'
    assert_response :success
    # assert_select 'body', /.*[Ll]ogin*/    
    assert_select "a[href=?]", '/auth/google' #Login with google
  end  

  test "successful login from google oauth" do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    get '/auth/google'
    assert_match "Redirecting to http://www.example.com/auth/google/callback...", response.body
    follow_redirect!
    assert_match /.*[Rr]edirected.*/, response.body
    follow_redirect!
    refute_match /.*erro.*/, response.body
    assert_select "a[href=?]", logout_path
  end  

  test "unauthorized login from google oauth" do
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: 'google',
      uid: '123545',
      info: {
        first_name: "Teste",
        last_name:  "LastName",
        email:      "email_nao_autorizado@teste.com"
      },
      credentials: {
        token: "123456",
        expires_at: Time.now + 1.week
      }
    })
   # puts "OmniAuth.config.mock_auth[:google]: #{OmniAuth.config.mock_auth[:google]}"
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    get '/auth/google'
    assert_match "Redirecting to http://www.example.com/auth/google/callback...", response.body
    follow_redirect!
    assert_match /.*[Rr]edirected.*/, response.body
    follow_redirect!
    assert_select "a[href=?]", '/auth/google' #Login with google
    assert_select 'body', /.*autorizado*/
    assert_select logout_path, false, "Não deve haver logout link nesta página"    
  end  
end
