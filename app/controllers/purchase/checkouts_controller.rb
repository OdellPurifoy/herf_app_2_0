# frozen_string_literal: true

module Purchase
  class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def create; end
  end
end
