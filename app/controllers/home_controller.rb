class HomeController < ApplicationController
  def show
    @response = Response.response_for_revision_by_user(@current_user)
  end
end
