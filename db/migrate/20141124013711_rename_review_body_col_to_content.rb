class RenameReviewBodyColToContent < ActiveRecord::Migration
  def change
    rename_column :reviews, :body, :content
  end
end
