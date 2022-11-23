class MessageReactionForm < ApplicationForm
  attr_accessor :user_id, :message_id, :type, :params, :message_reaction

  def submit
    assign_attributes(message_reaction_params)

    return false if invalid?

    self.message_reaction = MessageReaction.find_or_initialize_by(
      user_id: user_id,
      message_id: message_reaction_params[:message_id]
    )
    message_reaction.type = message_reaction_params[:type]
    message_reaction.save
  end

  private

  def message_reaction_params
    params.require(:message_reaction_form)
          .permit(:user_id, :message_id, :type)
  end
end
