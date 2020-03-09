require 'bcrypt'

class User < ActiveRecord::Base
  devise(
    :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :confirmable,
    :lockable,
    :trackable
  )

  has_many :setlists, :dependent => :destroy

  def is_normal_user?
    role == 'user'
  end

  def is_admin?
    role == 'admin'
  end

  def owns_setlist?(setlist)
    id == setlist.user.id
  end

  def name
    "#{first_name} #{last_name}"
  end

  def name_and_username
    buffer = []
    buffer << name if name.present?
    buffer << (name.present? ? "(#{username})" : "#{username}") if username.present?
    buffer.join ' '
  end
end
