class Idea < ActiveRecord::Base
  validates_numericality_of :rating, less_than: 3, greater_than: -1
  before_save :truncate_body

  def truncate_body
    if self.body.length > 100
      truncated_characters = self.body.slice(0, 100)
      if truncated_characters.last.match(/\w/)
        truncated_characters = truncated_characters.split(' ')[0..-2].join(' ')
      end
      self.body = truncated_characters
    end
  end
end