class ConvertLineItemsToPolymorphic < ActiveRecord::Migration

  def up
    add_column :line_items, :itemable_type, :string
    rename_column :line_items, :cart_id, :itemable_id
    add_index :line_items, [:itemable_id, :itemable_type]

    LineItem.update_all({itemable_type: 'Cart'})

  end

  def down
    remove_column :line_items, :itemable_type
    rename_column :line_items, :itemable_id, :cart_id
    remove_index  :line_items, :name => :index_line_items_on_itemable_id_and_itemable_type

  end
end
