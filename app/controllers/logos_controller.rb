# frozen_string_literal: true

class LogosController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_lounge

  def destroy
    @lounge.logo.purge_later

    respond_to do |format|
      format.html { redirect_to edit_lounge_path(@lounge) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@lounge, :logo))}
    end
  end

  private

  def set_lounge
    @lounge = Lounge.friendly.find(params[:lounge_id])
  end
end
