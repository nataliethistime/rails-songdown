class UserDecorator
  def full_name(user)
    buffer = []
    if user.first_name.present?
      buffer << user.first_name
      buffer << user.last_name if user.last_name.present?
    end
    buffer << (buffer.empty? ? user.username : "(#{user.username})") if user.username.present?
    buffer.join ' '
  end
end
