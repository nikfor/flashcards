class AddAttachmentAvatarToCards < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :cards, :avatar
  end
end
