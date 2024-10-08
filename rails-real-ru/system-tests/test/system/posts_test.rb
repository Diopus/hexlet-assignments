# frozen_string_literal: true

require 'application_system_test_case'

# BEGIN
class PostsTest < ApplicationSystemTestCase
    setup do
      @post = posts(:one)
    end
  
    test 'visiting the index' do
      visit posts_url
      assert_selector 'h1', text: 'Posts'
    end
  
    test 'should create post' do
      visit posts_url
      click_on 'New Post'
  
      title =  Faker::Lorem.paragraph
      body = Faker::Lorem.paragraph

      fill_in 'Title', with: title
      fill_in 'Body', with: body
      
      click_on 'Create Post'
      assert_text 'Post was successfully created'

      visit posts_url
      assert_text title
    end

    test 'should update Post' do
      visit post_url(@post)
      click_on('Edit', class: 'btn')

      title =  Faker::Lorem.paragraph
      body = Faker::Lorem.paragraph

      fill_in 'Title', with: title
      fill_in 'Body', with: body

      click_on 'Update Post'
      assert_text 'Post was successfully updated'

      click_on 'Back'
      assert_text body
    end

    test 'should destroy Post' do
      visit posts_url

      page.accept_confirm do
        find("a[href='/posts/#{@post.id}']", text: 'Destroy').click
      end

      assert_text 'Post was successfully destroyed'
      assert_no_selector "a[href='/posts/#{@post.id}/edit']"
    end
  end
# END
