# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :membership

  def initialize(user, membership)
    @user = user
    @membership = membership
  end

  def new?
    true
    # @user.admin? || @user.subscribed? || @user.id == @membership.lounge.user_id
  end

  def create?
    true
    # @user.admin? || @user.subscribed? || @user.id == @membership.lounge.user_id
  end

  def update?
    true
    # @user.admin? || @user.id == @membership.lounge.user_id
  end

  def destroy?
    true
    # @user.admin? || @user.id == @membership.lounge.user_id
  end
end
