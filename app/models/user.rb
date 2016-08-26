require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, :presence => true, :uniqueness => true, :length => 3..20
  validates :email, :presence => true, :uniqueness => true, :confirmation => true

  attr_accessor :password
  validates :password, :confirmation => true, :length => 6..20

  validates :password_confirmation, :presence => true
  validates :email_confirmation, :presence => true

  before_save :encrypt_password
  after_save :clear_password

  has_many :setlists, :dependent => :destroy

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def self.authenticate(username="", login_password="")
    user = User.find_by_username(username)

    if user && user.match_password(login_password)
      user
    else
      false
    end
  end

  def match_password(login_password)
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def is_normal_user?
    role == 'user'
  end

  def is_editor?
    role == 'editor' || role == 'admin'
  end

  def is_admin?
    role == 'admin'
  end

  def owns_setlist?(setlist)
    id == setlist.user.id
  end
end
