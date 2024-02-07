# frozen_string_literal: true

class AddNamesAndColorToUers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :color, :string
  end
end
