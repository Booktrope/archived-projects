class Signature < ActiveRecord::Base
  belongs_to :document
  belongs_to :signer
end
