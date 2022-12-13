class ChannelForm < ApplicationForm
  attr_accessor :params, :channel, :name, :type

  validates :name, presence: true, unless: -> { channel_params[:type] == Channel.types[:just_two_people] }

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
          .permit(:name, :type)
  end
end
