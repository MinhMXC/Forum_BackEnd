class ChangeAllowChangePasswordDefaultr < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :allow_password_change, true
  end
end
