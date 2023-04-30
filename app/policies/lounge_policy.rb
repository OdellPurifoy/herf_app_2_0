# frozen_string_literal: true

class LoungePolicy < ApplicationPolicy
  attr_reader :user, :lounge

  def initialize(user, lounge)
    @user = user
    @lounge = lounge
  end

  def new?
    @user.admin? || @user.subscribed?
  end

  def create?
    @user.admin? || @user.subscribed?
  end

  def update?
    @user.admin? || @user.id == lounge.user_id
  end

  def destroy?
    @user.admin? || @user.id == lounge.user_id
  end
end
