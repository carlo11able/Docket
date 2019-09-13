class User < ApplicationRecord


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  
  has_many :photos,  inverse_of: :user
  has_many :answers,  inverse_of: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  # def self.create_with_omniauth(auth)
  
  #   user = find_or_create_by(uid: auth['uid'], provider:  auth['provider'])
  #   user.email = "#{auth['uid']}@#{auth['provider']}.com"
  #   user.password = auth['uid']
  #   user.name = auth['info']['name']  
    
  #   if User.exists?(user)
  #     user
  #   else
  #     user.save!
  #     user
  #   end
  # end



  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      parse_name(user, auth.info.name)
    end
    
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  private
  def self.parse_name(user, name)
    name_arr = name.split(" ")
    user.surname = name_arr.pop
    user.name = name_arr.join(" ")
  end
end
