class UserDecorator < DecoratorBase
  def full_name(user)
    buffer = []
    if user.first_name.present?
      buffer << user.first_name
      buffer << user.last_name if user.last_name.present?
      buffer << "(#{user.username})" if user.username.present?
    elsif user.username.present?
      buffer << user.username
    else
      buffer << user.email
    end
    buffer.join ' '
  end
end
