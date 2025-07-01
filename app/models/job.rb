class Job < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :description, :salary, :category, presence: true
  validate :max_images

  scope :by_category, ->(cat) { where(category: cat) if cat.present? }
  scope :by_min_salary, ->(amount) { where("salary >= ?", amount.to_i) if amount.present? }

  def self.filter(params)
    by_category(params[:category])
      .by_min_salary(params[:min_salary])
  end

  private

  def max_images
    return unless images.attachments.size > 5

    errors.add(:images, "poți atașa maxim 5 imagini.")
  end
end
