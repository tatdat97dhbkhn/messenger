class ChangeNameTypeToChannels < ActiveRecord::Migration[7.0]
  def change
    change_table :channels do |t|
      t.change :name, :text
    end
  end
end
