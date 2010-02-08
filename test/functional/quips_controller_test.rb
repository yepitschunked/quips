require 'test_helper'

class QuipsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:quips)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_quip
    assert_difference('Quip.count') do
      post :create, :quip => { }
    end

    assert_redirected_to quip_path(assigns(:quip))
  end

  def test_should_show_quip
    get :show, :id => quips(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => quips(:one).id
    assert_response :success
  end

  def test_should_update_quip
    put :update, :id => quips(:one).id, :quip => { }
    assert_redirected_to quip_path(assigns(:quip))
  end

  def test_should_destroy_quip
    assert_difference('Quip.count', -1) do
      delete :destroy, :id => quips(:one).id
    end

    assert_redirected_to quips_path
  end
end
