# frozen_string_literal: true

class SpecialOfferPolicy < ApplicationPolicy
  attr_reader :user, :special_offer

  def initialize(user, special_offer)
    @user = user
    @special_offer = special_offer
  end

  def new?
    true
    # @user.admin? || @user.subscribed?
  end

  def create?
    true
    # @user.admin? || @user.subscribed?
  end

  def update?
    true
    # @user.admin? || @user.id == @special_offer.lounge.user_id
  end

  def destroy?
    true
    # @user.admin? || @user.id == @special_offer.lounge.user_id
  end
end
