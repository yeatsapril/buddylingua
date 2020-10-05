class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_reference :users, :native_language, index: true, foreign_key: { to_table: :languages }
    add_reference :users, :target_language, index: true, foreign_key: { to_table: :languages }
    add_column :users, :target_language_level, :integer
    add_reference :users, :gender, null: false, foreign_key: true
    add_column :users, :description, :text
    add_column :users, :address, :string
  end
end
