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
end
