# frozen_string_literal: true

namespace :message_reactions do
  task counter_culture_fix_counts: [:environment] do
    MessageReaction.counter_culture_fix_counts
  end
end
