# frozen_string_literal: true

class PriceListingsController < ApplicationController
  def pricing
    @faqs = parse_yaml("#{Rails.root.to_s}/static_data/faqls.yml")
  end
end
