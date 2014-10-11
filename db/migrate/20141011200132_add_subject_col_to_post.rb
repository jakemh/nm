class AddSubjectColToPost < ActiveRecord::Migration
  def change
    add_column :posts, :subject, :text
  end
end
