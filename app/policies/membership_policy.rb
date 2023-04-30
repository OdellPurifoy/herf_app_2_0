# frozen_string_literal: true

class MembershipPolicy < ApplicationPolicy
  attr_reader :user, :membership

  def initialize(user, membership)
    @user = user
    @membership = membership
  end

  def new?
    @user.admin? || @user.subscribed? || @user.id == @membership.lounge.user_id
  end

  def create?
    @user.admin? || @user.subscribed? || @user.id == @membership.lounge.user_id
  end

  def update?
    @user.admin? || @user.id == @membership.lounge.user_id
  end

  def destroy?
    @user.admin? || @user.id == @membership.lounge.user_id
  end
end
