require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password")
    sign_in_as(@user, "password")
  end


  test "get new article form and create article" do
    get new_article_path
    assert_template 'articles/new'

    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Create Articles Test", description: "This is the test article description." } }
      follow_redirect!
    end
    assert_template 'articles/show'
  end


  test "prevent article creation if title is too short" do
    get new_article_path
    assert_template 'articles/new'

    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: "a", description: "This is the test article description." } }
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
