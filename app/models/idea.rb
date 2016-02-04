class Idea < ActiveRecord::Base
  validates_numericality_of :rating, less_than: 3, greater_than: -1
end