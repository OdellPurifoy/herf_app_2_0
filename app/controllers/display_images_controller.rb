# frozen_string_literal: true

class DisplayImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lounge

  def destroy
    @lounge.display_image.purge_later

    respond_to do |format|
      format.html { redirect_to edit_lounge_path(@lounge) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@lounge, :display_image))}
    end
  end

  private

  def set_lounge
    @lounge = Lounge.friendly.find(params[:lounge_id])
  end
end
