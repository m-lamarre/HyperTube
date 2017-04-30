class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username,
            uniqueness: true,
            presence: true,
            format:  { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable,
         :omniauthable, omniauth_providers: %i(google_oauth2)

  mount_uploader :profile_picture, AvatarUploader

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    if user.blank?
      user = User.new
      user.email = auth.info.email
      user.username = user.get_unique_username(auth.info.email)
      #user.avatar = open auth.info.image <- for when images are in
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_confirmation!
      user.save!
    end

    user
  end

  def get_unique_username(email)
    username = email.split('@').first
    num = 2
    until(User.find_by(username: username).blank?)
      username = "#{username}#{num}"
      num += 1
    end

    username
  end
end
