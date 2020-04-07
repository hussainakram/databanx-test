# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :render_user_unauthorized

  private

  def render_user_unauthorized
    respond_to do |format|
      format.json { render(json: { errors: ['User not authorized'] }, status: :bad_request) }
      format.html do
        flash[:error] = 'Error: User not authorized'
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
