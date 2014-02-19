class RemoveExample1AndExample2FromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :example1
    remove_column :questions, :example1
  end
end
