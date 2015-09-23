class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      # Admin
      can :manage, :all
    elsif user.id.present?
      # Normal user
      can :destroy, :session

      can :read, CatEntry
      can :create, CatEntry
      can :update, CatEntry, :user_id => user.id
      can :destroy, CatEntry, :user_id => user.id

      can :read, User, :id => user.id
      can :update, User, :id => user.id
    else
      # Guest
      can :create, :session
      
      can :read, CatEntry
    end
  end
end
