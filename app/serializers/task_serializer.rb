class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :position, :status, :deadline

  has_many :comments
end
