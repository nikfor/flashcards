class AddCurrentToPacks < ActiveRecord::Migration
  def change
    add_column :packs, :current, :boolean, default: false
  end
end
