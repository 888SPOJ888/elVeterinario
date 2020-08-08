class Client < ApplicationRecord
    has_many :pets, dependent: :destroy
    accepts_nested_attributes_for :pets, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

    def to_s
        name
    end

    #Cantidad de mascotas que tiene
    def count_pet
        pets.count
    end
end
