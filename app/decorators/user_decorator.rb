# frozen_string_literal: true

# This is your user decorator
class UserDecorator < ApplicationDecorator
  delegate_all

  def status_to_css
    case object.status
    when 'online'
      'bg-green-500'
    when 'away'
      'bg-orange-500'
    when 'offline'
      'bg-stone-500'
    else
      ''
    end
  end
end
