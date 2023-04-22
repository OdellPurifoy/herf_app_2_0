class DisplayImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lounge

  def destroy
    @lounge.display_image.purge_later
    redirect_to edit_lounge_path(@lounge)
  end
  
  private
  
  def set_lounge
    @lounge = Lounge.friendly.find(params[:lounge_id])
  end
end