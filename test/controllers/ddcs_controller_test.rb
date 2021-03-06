require 'test_helper'

class DdcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ddc = ddcs(:one)
  end

  test "should get index" do
    get ddcs_url
    assert_response :success
  end

  test "should get new" do
    get new_ddc_url
    assert_response :success
  end

  test "should create ddc" do
    assert_difference('Ddc.count') do
      post ddcs_url, params: { ddc: { string: @ddc.string } }
    end

    assert_redirected_to ddc_url(Ddc.last)
  end

  test "should show ddc" do
    get ddc_url(@ddc)
    assert_response :success
  end

  test "should get edit" do
    get edit_ddc_url(@ddc)
    assert_response :success
  end

  test "should update ddc" do
    patch ddc_url(@ddc), params: { ddc: { string: @ddc.string } }
    assert_redirected_to ddc_url(@ddc)
  end

  test "should destroy ddc" do
    assert_difference('Ddc.count', -1) do
      delete ddc_url(@ddc)
    end

    assert_redirected_to ddcs_url
  end
end
