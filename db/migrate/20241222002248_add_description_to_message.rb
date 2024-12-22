class AddDescriptionToMessage < ActiveRecord::Migration[8.0]
  def change
    add_reference :messages, :description, foreign_key: { to_table: :action_text_rich_texts }
  end
end
