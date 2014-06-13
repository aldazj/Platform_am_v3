require 'test_helper'

class VideoitemsControllerTest < ActionController::TestCase
  setup do
    @videoitem = videoitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videoitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create videoitem" do
    assert_difference('Videoitem.count') do
      post :create, videoitem: { date: @videoitem.date, description: @videoitem.description, is_available: @videoitem.is_available, pathvideo: @videoitem.pathvideo, title: @videoitem.title, views: @videoitem.views }
    end

    assert_redirected_to videoitem_path(assigns(:videoitem))
  end

  test "should show videoitem" do
    get :show, id: @videoitem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @videoitem
    assert_response :success
  end

  test "should update videoitem" do
    patch :update, id: @videoitem, videoitem: { date: @videoitem.date, description: @videoitem.description, is_available: @videoitem.is_available, pathvideo: @videoitem.pathvideo, title: @videoitem.title, views: @videoitem.views }
    assert_redirected_to videoitem_path(assigns(:videoitem))
  end

  test "should destroy videoitem" do
    assert_difference('Videoitem.count', -1) do
      delete :destroy, id: @videoitem
    end

    assert_redirected_to videoitems_path
  end
end
