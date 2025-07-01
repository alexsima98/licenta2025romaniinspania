class Housing < ApplicationRecord
  belongs_to :user

  has_many_attached :images

  validates :title, :description, :price, :location, presence: true
end
