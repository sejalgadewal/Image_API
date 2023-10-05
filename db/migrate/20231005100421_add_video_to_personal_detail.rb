class AddVideoToPersonalDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :personal_details, :video, :string

  end
end
