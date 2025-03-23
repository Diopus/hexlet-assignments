# frozen_string_literal: true

class Api::V1::UsersController < Api::ApplicationController
  # BEGIN
  def index
    @users = User.includes(:posts)
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @user_posts = @user.posts
  end
  # END
end
