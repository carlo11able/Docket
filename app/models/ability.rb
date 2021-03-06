class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  
    user ||= User.new

    # if user.admin?  # additional permissions for logged in users (they can manage their posts)
    #   #cannot :manage, Photo, user_id: user.id 
    #   can :manage, :all
    # else
    #   cannot :manage, :all
    # end

    # if user.has_role? :admin
    #   can :update, Photo
    # else
    #   cannot :update, Photo
    # end
    if user.has_role? :customer  # additional permissions f o r logged in users (they can manage their posts)
      can [:read,:update,:delete],User, id: user.id

      can :manage, Photo, user_id: user.id
      can :manage, Question, photo: {user: {id: user.id } }
      #cannot :manage, Answer
    else
      if user.has_role? :labeler
        can [:read,:update,:delete],User, id: user.id
        can :manage, Answer, user_id: user.id
        #can :read, Question
      else
        if user.has_role? :admin
          can :manage, :all
        else
          cannot :manage, :all
        end
      end
    
    end


  end
end
