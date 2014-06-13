require 'test_helper'

class PersonalgroupsControllerTest < ActionController::TestCase
  setup do
    @personalgroup = personalgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personalgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create personalgroup" do
    assert_difference('Personalgroup.count') do
      post :create, personalgroup: { person_id: @personalgroup.person_id }
    end

    assert_redirected_to personalgroup_path(assigns(:personalgroup))
  end

  test "should show personalgroup" do
    get :show, id: @personalgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @personalgroup
    assert_response :success
  end

  test "should update personalgroup" do
    patch :update, id: @personalgroup, personalgroup: { person_id: @personalgroup.person_id }
    assert_redirected_to personalgroup_path(assigns(:personalgroup))
  end

  test "should destroy personalgroup" do
    assert_difference('Personalgroup.count', -1) do
      delete :destroy, id: @personalgroup
    end

    assert_redirected_to personalgroups_path
  end
end
