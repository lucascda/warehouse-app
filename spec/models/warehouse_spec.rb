require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', adress: 'Endereço',
                                  cep: '25000-000', city: 'Rio', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse.valid?).to be_falsey
      end
  
      it 'false when code is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: '', adress: 'Endereço',
                                  cep: '25000-000', city: 'Rio de Janeiro', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid
      end
  
      it 'false when adress is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: '',
                                  cep: '25000-000', city: 'Rio de Janeiro', area: 1000,
                                  description: 'Alguma descrição')
        
        expect(warehouse).not_to be_valid
      end

      it 'false when cep is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço',
          cep: '', city: 'Rio de Janeiro', area: 1000,
          description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'false when city is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço',
          cep: '25000-000', city: '', area: 1000,
          description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'false when area is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço',
          cep: '25000-000', city: 'Rio de Janeiro', area: '',
          description: 'Alguma descrição')

        expect(warehouse).not_to be_valid
      end

      it 'false when description is empty' do
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', adress: 'Endereço',
          cep: '25000-000', city: 'Rio de Janeiro', area: 1000,
          description: '')

        expect(warehouse).not_to be_valid
      end
      # TODO: unit testing blank attributes

    end
    
    context 'uniqueness' do
      it 'false when code is already in use' do
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', adress: 'Endereço',
                                        cep: '25000-000', city: 'Rio', area: 1000,
                                        description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', adress: 'Avenida',
                                         cep: '35000-000', city: 'Niteroi', area: 1500,
                                         description: 'Outra descrição')
        
  
        result = second_warehouse.valid?
        expect(result).to eq false
  
      end

      it 'false when name is already in use' do
        first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', adress: 'Endereço',
          cep: '25000-000', city: 'Rio', area: 1000,
          description: 'Alguma descrição')
        second_warehouse = Warehouse.new(name: 'Rio', code: 'RIO2', adress: 'Avenida',
            cep: '35000-000', city: 'Niteroi', area: 1500,
            description: 'Outra descrição')
        
        expect(second_warehouse.valid?).to eq false

      end
    end

    context 'format' do
      it 'false when cep has wrong format' do
        warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', adress: 'Avenida',
          cep: '11111111', city: 'Niteroi', area: 1500,
          description: 'Outra descrição')
      
        expect(warehouse.valid?).to eq false
      end      
    end


    
    
  end
end
