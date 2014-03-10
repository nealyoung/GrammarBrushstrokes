class HomeController < ApplicationController
  def show
    @response = Response.response_for_revision_by_user(@current_user)
    @latest_announcement = Announcement.order("updated_at").last
    @time = @latest_announcement.updated_at.to_time
  end
end
