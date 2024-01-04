require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @post_comment = post_comments(:one)
  end

  test "should get new" do
    get new_post_comment_path(@post_comment.post)
    assert_response :success
  end

  test "should create post_comment" do
    assert_difference("PostComment.count") do
      post post_comments_path(@post_comment.post), params: { post_comment: { body: @post_comment.body, post_id: @post_comment.post_id } }
    end

    assert_redirected_to post_path(@post_comment.post)
  end

  test "should show post_comment" do
    get comment_path(@post_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_comment_path(@post_comment)
    assert_response :success
  end

  test "should update post_comment" do
    @post = @post_comment.post
    patch comment_path(@post_comment), params: { post_comment: { body: @post_comment.body, post_id: @post_comment.post_id } }
    assert_redirected_to comment_path
  end

  test "should destroy post_comment" do
    assert_difference("PostComment.count", -1) do
      delete comment_path(@post_comment)
    end

    assert_redirected_to post_path
  end
end
