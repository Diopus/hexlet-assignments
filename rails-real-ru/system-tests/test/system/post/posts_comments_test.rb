# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostCommentsTest < ApplicationSystemTestCase
    setup do
      @post_two = posts(:two)
      @post_comment_one = post_comments(:one)
      @post_comment_two = post_comments(:two)
    end
  
    test 'should create post comment' do
      visit post_url(@post_two)

      assert_selector 'h1', text: @post_two.title, wait: 2

      body = Faker::Lorem.paragraph
      fill_in 'post_comment_body', with: body
      find('input[type="submit"]').click

      assert_text 'Comment was successfully created.'
      assert_text body
    end
  
    test 'should update Post comment' do
      visit post_url(@post_comment_one.post)

      assert_selector 'h1', text: @post_comment_one.post.title, wait: 2

      find("a[href='/posts/#{@post_comment_one.post.id}/comments/#{@post_comment_one.id}/edit']").click

      body = Faker::Lorem.paragraph
      fill_in 'Body', with: body
      find('input[type="submit"]').click

      assert_text 'Comment was successfully updated.'
      assert_text body
    end
  
    test 'should destroy Post comment' do
      visit post_url(@post_comment_two)

      assert_selector 'h1', text: @post_comment_two.post.title, wait: 2

      page.accept_confirm do
        find("a[href='/posts/#{@post_comment_two.post.id}/comments/#{@post_comment_two.id}']", text: 'Delete').click
      end

      assert_text 'Comment was successfully destroyed.'
      assert_no_selector "a[href='/posts/#{@post_comment_two.post.id}/comments/#{@post_comment_two.id}/edit']"
    end
  end
# END
