class PetHistory < ApplicationRecord
  belongs_to :pet

  def to_s
    name
  end
end
