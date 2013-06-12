require 'test_helper'

class FilepostingsControllerTest < ActionController::TestCase
  setup do
    @fileposting = filepostings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filepostings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fileposting" do
    assert_difference('fileposting.count') do
      post :create, fileposting: {file: @fileposting.file}
    end

    assert_redirected_to fileposting_path(assigns(:fileposting))
  end

  test "should show fileposting" do
    get :show, id: @fileposting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fileposting
    assert_response :success
  end

  test "should update fileposting" do
    patch :update, id: @fileposting, fileposting: {file: @fileposting.file}
    assert_redirected_to fileposting_path(assigns(:fileposting))
  end

  test "should destroy fileposting" do
    assert_difference('fileposting.count', -1) do
      delete :destroy, id: @fileposting
    end

    assert_redirected_to filepostings_path
  end
end
