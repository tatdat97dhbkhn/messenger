# frozen_string_literal: true

module Messages
  # This is your messages/attach_gif job
  class AttachGifJob < ApplicationJob
    queue_as :default

    def perform(**options)
      filename = File.basename(URI.parse(options[:gif_url]).path)
      file = URI.parse(options[:gif_url]).open

      options[:message].attachments.attach(io: file, filename:)
    end
  end
end
