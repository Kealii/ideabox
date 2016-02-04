class IdeaSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :rating
end
