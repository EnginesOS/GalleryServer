class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :authentication_keys => [:username]

  has_many :comments, dependent: :destroy


  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  validates_format_of :email, :with => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_presence_of :password, :on=>:create
  validates_confirmation_of :password, :on=>:create
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true

  # validates :username, presence: true, uniqueness: {case_sensitive: false}, length: { within: 8..128 }
  # validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  # validate :password_valid

  # def password_valid
  #   if password.present?
  #     if password.length < 8 || password.length > 128
  #       errors.add(:password, "must be 8 to 128 charaters.")
  #     elsif password != password_confirmation
  #       errors.add(:password_confirmation, "must be same as password.")
  #     end
  #   end
  # end

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     where(conditions).first
  #   end
  # end

end
