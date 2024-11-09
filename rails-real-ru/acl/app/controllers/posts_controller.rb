# frozen_string_literal: true

class PostsController < ApplicationController
  after_action :verify_authorized, except: %i[index show]

  # BEGIN
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find params[:id]
    authorize @post
  end

  def new
    raise Pundit::NotAuthorizedError, "You must be logged in to create a post" unless current_user
    @post = current_user.posts.build
    authorize @post
  end

  def edit
    @post = Post.find params[:id]
    authorize @post
  end

  def create
    raise Pundit::NotAuthorizedError, "You must be logged in to create a post" unless current_user

    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find params[:id]
    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find params[:id]
    authorize @post

    @post&.destroy!

    redirect_to posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
