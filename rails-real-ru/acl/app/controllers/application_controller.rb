# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pundit::Authorization

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end
