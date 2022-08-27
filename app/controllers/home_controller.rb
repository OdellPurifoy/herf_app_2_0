# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @featured_lounges = Lounge.featured
    @lounges = Lounge.all
  end
end