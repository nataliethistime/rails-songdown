# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User, id: user.id
    can :manage, Song, user_id: user.id
  end
end
