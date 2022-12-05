class RemoveReadAtFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :read_at
  end
end
