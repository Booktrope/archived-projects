class Signer < ActiveRecord::Base
  has_many :signatures
  has_many :documents, through: :signatures

  validates_presence_of :name, :email
end
