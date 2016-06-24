class AddPackIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :pack_id, :integer
  end
end
