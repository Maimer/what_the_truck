class AddVotesCounterCacheToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :votes_count, :integer, default: 0
  end
end
