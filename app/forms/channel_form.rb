class ChannelForm < ApplicationForm
  attr_accessor :params, :channel, :name, :type, :photo, :skip_validate_name

  validates :name, presence: true, if: -> { params.dig(:channel_form, :skip_validate_name).blank? }

  def submit
    assign_attributes(channel_params)

    return false if invalid?

    self.channel = Channel.new if channel.nil?
    channel.assign_attributes(channel_params)

    channel.save
  end

  private

  def channel_params
    params.require(:channel_form)
          .permit(:name, :type, :photo)
  end
end
