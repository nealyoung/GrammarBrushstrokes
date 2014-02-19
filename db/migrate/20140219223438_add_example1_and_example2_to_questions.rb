class AddExample1AndExample2ToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :example1, :string
    add_column :questions, :example2, :string
  end
end
