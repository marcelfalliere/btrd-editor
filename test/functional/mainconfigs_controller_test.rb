require 'test_helper'

class MainconfigsControllerTest < ActionController::TestCase
  setup do
    @mainconfig = mainconfigs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mainconfigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mainconfig" do
    assert_difference('Mainconfig.count') do
      post :create, :mainconfig => @mainconfig.attributes
    end

    assert_redirected_to mainconfig_path(assigns(:mainconfig))
  end

  test "should show mainconfig" do
    get :show, :id => @mainconfig.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mainconfig.to_param
    assert_response :success
  end

  test "should update mainconfig" do
    put :update, :id => @mainconfig.to_param, :mainconfig => @mainconfig.attributes
    assert_redirected_to mainconfig_path(assigns(:mainconfig))
  end

  test "should destroy mainconfig" do
    assert_difference('Mainconfig.count', -1) do
      delete :destroy, :id => @mainconfig.to_param
    end

    assert_redirected_to mainconfigs_path
  end
end
