class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :comments, dependent: :destroy
  has_many :movies, through: :watched_movies
  has_many :watched_movies, dependent: :destroy

  validates :username,
            uniqueness: true,
            presence: true,
            format:  { with: /^[a-zA-Z0-9_\.]*$/, multiline: true }
  validates_presence_of :first_name, :last_name

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable,
         :omniauthable, omniauth_providers: %i(google_oauth2 marvin)

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
      user.get_unique_username(auth.info.email)
      user.get_firstname_and_lastname(auth)
      user.profile_picture = auth.info.image
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.skip_confirmation!
      user.save!
    end

    user
  end

  def get_firstname_and_lastname(auth)
    if auth.provider == 'marvin'
      self.first_name = auth.extra.raw_info.first_name
      self.last_name = auth.extra.raw_info.last_name
    else
      self.first_name = auth.info.first_name
      self.last_name = auth.info.last_name
    end
  end

  def get_unique_username(email)
    self.username = email.split('@').first
    num = 2
    until(User.find_by(username: self.username).blank?)
      self.username = "#{username}#{num}"
      num += 1
    end
  end
end
