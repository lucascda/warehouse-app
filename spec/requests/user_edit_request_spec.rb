require 'rails_helper'

describe 'usuário edita um pedido' do
  it 'e não é o dono' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    user2 = User.create!(name: 'Pedro', email: 'pedro@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')    
    supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    order = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    login_as(user)
    patch(order_path(order.id), params: { order: { supplier_id: 3}})

    expect(response).to redirect_to(root_path)
  end
end
