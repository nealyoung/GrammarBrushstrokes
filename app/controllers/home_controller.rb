class HomeController < ApplicationController
  def show
    @latest_announcement = Announcement.order("updated_at").last;
  end
end
