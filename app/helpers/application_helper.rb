# frozen_string_literal: true

# This is your application helper
module ApplicationHelper
  include Pagy::Frontend

  def render_turbo_stream_flash_messages
    turbo_stream.replace 'flash-messages', partial: 'shared/flash_messages'
  end

  def active_class_if_url(url)
    return 'bg-indigo-700' if current_page?(url)

    'hover:bg-indigo-700'
  end

  def send_message_at_format(time)
    if time.year == Time.current.year
      if time.yday == Time.current.yday
        l(time, format: :only_hour)
      else
        l(time, format: :only_day_month)
      end
    else
      l(time, format: :long)
    end
  end
end
