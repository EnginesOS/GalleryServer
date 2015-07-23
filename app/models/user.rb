class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable #, :validatable

  attr_accessor :login, :update_password

  has_many :comments, dependent: :destroy

  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: { within: 6..40 }
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  # validates :password
  validate :password_valid

  def password_valid
    if update_password == true
      if password.to_s == ""
        errors.add(:password, ["Password", "can't be blank"])
      elsif password.length < 6 || password.length > 40
        errors.add(:password, ["Password", "must be 6 to 40 charaters."])
      elsif password != password_confirmation
        errors.add(:password_confirmation, ["Password confirmation", "must be same as password."])
      end
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
