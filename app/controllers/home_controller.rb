class HomeController < ApplicationController
    def index
        @lounges = Lounge.featured
    end
end