class AnnouncementsController < ApplicationController
  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  # GET /announcements
  # GET /announcements.json
  def index
    if !@current_user.is_teacher?
      redirect_to root_path
    end

    @announcements = Announcement.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
    if !@current_user.is_teacher?
      redirect_to root_path
    end
  end

  # GET /announcements/new
  def new
    if !@current_user.is_teacher?
      redirect_to root_path
    end

    @announcement = Announcement.new
  end

  # GET /announcements/1/edit
  def edit
    if !@current_user.is_teacher?
      redirect_to root_path
    end
  end

  # POST /announcements
  # POST /announcements.json
  def create
    if !@current_user.is_teacher?
      redirect_to root_path
    end

    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  def update
    if !@current_user.is_teacher?
      redirect_to root_path
    end

    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  def destroy
    if !@current_user.is_teacher?
      redirect_to root_path
    end

    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:created_at, :updated_at, :content)
    end
end
