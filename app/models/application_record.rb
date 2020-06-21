class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.decorate_with(decorator_class)
    include MiniDecorator.new(decorator_class.new)
  end
end
