class Task < ApplicationRecord
  validates :title, presence:true
  validates :content, presence:true
  enum priority: [:low, :medium, :high]
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

end
