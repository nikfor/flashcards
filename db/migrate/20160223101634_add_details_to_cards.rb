class AddDetailsToCards < ActiveRecord::Migration
  def change
    change_column_null :cards, :original_text, false
    change_column_null :cards, :translated_text, false
  end
end
