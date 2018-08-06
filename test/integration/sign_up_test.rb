require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  def setup
    get signup_path
    assert_template 'users/new'
  end

  test "get signup form and sign up new user" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "john", email: "john@example.com", password: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
  end


  test "sign up should not be allowed if name is too short" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "j", email: "j@example.com", password: "password" } }
    end
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end


end
