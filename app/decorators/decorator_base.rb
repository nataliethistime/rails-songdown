class DecoratorBase
  def helpers
    ApplicationController.helpers
  end

  def created_at_ago(item)
    helpers.time_ago_in_words(item.created_at) + ' ago'
  end

  def updated_at_ago(item)
    helpers.time_ago_in_words(item.updated_at) + ' ago'
  end
end
