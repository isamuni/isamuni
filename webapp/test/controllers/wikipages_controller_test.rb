require 'test_helper'

class WikipagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wikipage = wikipages(:one)
  end

  test "should get index" do
    get wikipages_url
    assert_response :success
  end

  test "should get new" do
    get new_wikipage_url
    assert_response :success
  end

  test "should create wikipage" do
    assert_difference('Wikipage.count') do
      post wikipages_url, params: { wikipage: { content: @wikipage.content, name: @wikipage.name, slug: @wikipage.slug } }
    end

    assert_redirected_to wikipage_url(Wikipage.last)
  end

  test "should show wikipage" do
    get wikipage_url(@wikipage)
    assert_response :success
  end

  test "should get edit" do
    get edit_wikipage_url(@wikipage)
    assert_response :success
  end

  test "should update wikipage" do
    patch wikipage_url(@wikipage), params: { wikipage: { content: @wikipage.content, name: @wikipage.name, slug: @wikipage.slug } }
    assert_redirected_to wikipage_url(@wikipage)
  end

  test "should destroy wikipage" do
    assert_difference('Wikipage.count', -1) do
      delete wikipage_url(@wikipage)
    end

    assert_redirected_to wikipages_url
  end
end
