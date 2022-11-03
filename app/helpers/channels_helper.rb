module ChannelsHelper
  def generate_just_two_people_channel_name(user_one, user_two)
    user_ids = [user_one.id, user_two.id].sort
    "just_two_people_#{user_ids[0]}_#{user_ids[1]}"
  end
end
