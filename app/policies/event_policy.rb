# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def new?
    @user.admin? || @user.subscribed?
  end

  def create?
    @user.admin? || @user.subscribed?
  end

  def update?
    @user.admin? || @user.id == @event.lounge.user_id
  end

  def destroy?
    @user.admin? || @user.id == @event.lounge.user_id
  end
end
