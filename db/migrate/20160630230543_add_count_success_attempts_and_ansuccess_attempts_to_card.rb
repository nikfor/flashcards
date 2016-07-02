class AddCountSuccessAttemptsAndAnsuccessAttemptsToCard < ActiveRecord::Migration
  def change
    add_column :cards, :count_success_attempts, :integer, default: 0
    add_column :cards, :count_unsuccess_attempts, :integer, default: 0
  end
end
