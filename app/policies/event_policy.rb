# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def new?
    true
    # @user.admin? || @user.subscribed? || @user.id == @event.lounge.user_id
  end

  def create?
    true
    # @user.admin? || @user.subscribed? || @user.id == @event.lounge.user_id
  end

  def update?
    true
    # @user.admin? || @user.id == @event.lounge.user_id
  end

  def destroy?
    true
    # @user.admin? || @user.id == @event.lounge.user_id
  end
end
