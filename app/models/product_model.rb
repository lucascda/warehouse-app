class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :width, :depth, :height, :supplier, :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, length: { is: 20}
  validates :weight, :width, :depth, :height, comparison: { greater_than: 0}
end
