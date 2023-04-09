# frozen_string_literal: true

class LoungePolicy < ApplicationPolicy
  attr_reader :user, :lounge

  def initialize(user, lounge)
    @user = user
    @lounge = lounge
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
    # @user.admin? || @user.id == lounge.user_id
  end

  def destroy?
    true
    # @user.admin? || @user.id == lounge.user_id
  end
end
