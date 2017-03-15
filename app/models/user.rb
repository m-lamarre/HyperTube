class User < ApplicationRecord
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :username, :email, :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:login]
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates(:username, presence: true,
            length: { maximum: 20 },
            uniqueness: { case_sensitive: true })
  validates(:first_name, presence: true,
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false })
  validates(:last_name, presence: true,
            length: { maximum: 20 },
            uniqueness: { case_sensitive: false })
  validates(:email, presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false })
  validates(:password, presence: true, length: { minimum: 6 })


  def initialize(params = {})
    super(params)
    @username  = params[:username]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
  end

  def login=(login)
   @login = login
  end

  def login
   @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
