module ReactionHelper
  def reactions
    reaction_paths = Dir.glob(Rails.root.join('app', 'assets', 'images', 'reactions', '*.gif'))

    reaction_paths.each_with_object([]) do |reaction_path, array|
      reaction_name = File.basename(reaction_path, '.gif')

      array.push(
        {
          type: reaction_name,
          path: "reactions/#{reaction_name}.gif"
        }
      )
    end
  end
end
