class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates_presence_of :comment
  validates_presence_of :movie
  validates_presence_of :user
end
