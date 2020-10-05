class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :user_1, index: true, foreign_key: { to_table: :users }
      t.references :user_2, index: true, foreign_key: { to_table: :users }
    end
  end
end
