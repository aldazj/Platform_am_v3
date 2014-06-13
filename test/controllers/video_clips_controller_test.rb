require 'test_helper'

class VideoClipsControllerTest < ActionController::TestCase
  setup do
    @video_clip = video_clips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:video_clips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create video_clip" do
    assert_difference('VideoClip.count') do
      post :create, video_clip: { date: @video_clip.date, description: @video_clip.description, is_available: @video_clip.is_available, title: @video_clip.title, views: @video_clip.views }
    end

    assert_redirected_to video_clip_path(assigns(:video_clip))
  end

  test "should show video_clip" do
    get :show, id: @video_clip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @video_clip
    assert_response :success
  end

  test "should update video_clip" do
    patch :update, id: @video_clip, video_clip: { date: @video_clip.date, description: @video_clip.description, is_available: @video_clip.is_available, title: @video_clip.title, views: @video_clip.views }
    assert_redirected_to video_clip_path(assigns(:video_clip))
  end

  test "should destroy video_clip" do
    assert_difference('VideoClip.count', -1) do
      delete :destroy, id: @video_clip
    end

    assert_redirected_to video_clips_path
  end
end
