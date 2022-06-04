require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'gera um codigo aleatorio' do
    it 'ao criar um novo pedido' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                description: 'Galpão destinado para cargas internacionais')
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
                                  registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
                                  city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
      
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      order.save!
      result = order.code
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end
    it 'e o código é unico' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpão destinado para cargas internacionais')
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
                      registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
                      city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')

      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      second_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')

      second_order.save!
      expect(second_order.code).not_to eq first_order.code
    end
  end

  describe '#valid?' do
    it 'deve ter um código' do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais')
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
      supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
                registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
                city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      result = order.valid?
      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
     order = Order.new(estimated_delivery_date: '')        
     order.valid?
     expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data estimada de entrega não deve ser passada' do
      order = Order.new(estimated_delivery_date: 1.day.ago)
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega não deve ser igual a hoje' do
      order = Order.new(estimated_delivery_date: Date.today)
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      expect(result).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega deve ser igual ou maior que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      order.valid?
      result = order.errors.include? :estimated_delivery_date
      expect(result).to be false
      
    end
  end
end
