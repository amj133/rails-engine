class Merchant < ApplicationRecord
  validates_presence_of :name, :created_at, :updated_at

  def self.random
    order('RANDOM()').first
  end
  
end
