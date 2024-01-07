# frozen_string_literal: true

require 'test_helper'

class RuTranslationTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:without_comments)
    @locale = :ru

    @post_attrs = {
      title: Faker::Movies::Ghostbusters.character,
      body: Faker::Movies::Ghostbusters.quote
    }

    @post_comment_attrs = {
      body: Faker::Movies::Lebowski.quote
    }
  end

  test 'home#index' do
    get root_path(locale: @locale)

    assert_select 'h1', text: 'Домашняя страница'
    assert_select 'ul.nav', text: /Домой/
    assert_select 'ul.nav', text: /Посты/
    assert_select 'footer', text: /Хекслет/
  end

  test 'posts#index' do
    get posts_path(locale: @locale)

    assert_select 'h1', text: 'Посты'
    assert_select '#new-post-link', text: 'Новый пост'
  end

  test 'posts#new' do
    get new_post_path(locale: @locale)

    assert_select 'h1', text: 'Новый пост'
    assert_select '.new_post>.btn-success[value=?]', 'Создать пост'
    assert_select '.new_post #post_title[placeholder=?]', 'Название'
  end

  test 'posts#create check validation' do
    post posts_url(locale: @locale), params: { post: { title: nil } }

    assert_response :unprocessable_entity

    assert_select '.new_post .post_title .invalid-feedback', 'Название должно быть заполнено'
  end

  test 'posts#create successfully' do
    post posts_url(locale: @locale), params: { post: @post_attrs }

    follow_redirect!

    assert_select '.alert-info', 'Пост успешно создан'
  end

  test 'posts#update' do
    patch post_url(@post, locale: @locale), params: { post: @post_attrs }

    follow_redirect!

    assert_select '.alert-info', 'Пост успешно обновлён'
  end

  test 'posts#destroy' do
    delete post_url(@post, locale: @locale)

    follow_redirect!

    assert_select '.alert-info', 'Пост успешно удалён'
  end

  test 'comment#create' do
    post post_comments_url(@post, locale: @locale), params: { post_comment: @post_comment_attrs }

    follow_redirect!

    assert_select '.alert-info', 'Комментарий успешно создан'
  end

  test 'comment#update' do
    comment = post_comments(:one)
    post = comment.post

    patch post_comment_url(post, comment, locale: @locale), params: { post_comment: @post_comment_attrs }

    follow_redirect!

    assert_select '.alert-info', 'Комментарий успешно обновлён'
  end
end
