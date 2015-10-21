class AddCompleteToLists < ActiveRecord::Migration
  def change
    add_column :lists, :complete, :boolean, default: false
  end
end
