# frozen_string_literal: true

class LoungePolicy
  attr_reader :user, :lounge

  def initialize(user, lounge)
    @user = user
    @lounge = lounge
  end

  def update?
    @user.admin? || @user.id == lounge.user_id
  end
end
