# frozen_string_literal: true

class SpecialOfferPolicy < ApplicationPolicy
  attr_reader :user, :special_offer

  def initialize(user, special_offer)
    @user = user
    @special_offer = special_offer
  end

  def new?
    @user.admin? || @user.subscribed?
  end

  def create?
    @user.admin? || @user.subscribed?
  end

  def update?
    @user.admin? || @user.id == @special_offer.lounge.user_id
  end

  def destroy?
    @user.admin? || @user.id == @special_offer.lounge.user_id
  end
end
