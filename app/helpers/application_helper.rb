module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "shared/flash_messages"
  end

  def active_class_if_url(url)
    return 'bg-indigo-700' if current_page?(url)

    'hover:bg-indigo-700'
  end
end
