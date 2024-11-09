# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  attr_reader :user, :post


  def initialize(user, post)
    @user = user
    @post = post
  end

  # BEGIN
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    user&.id == post&.author_id || user&.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user&.admin?
  end
  # END
end
