require 'rails_helper'

describe 'usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'
    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    user1 = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    user2 = User.create!(name: 'Carla', email: 'carla@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    order1 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    order2 = Order.create!(user: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    order3 = Order.create!(user: user1, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
    
    login_as(user1)
    visit root_path
    click_on 'Meus Pedidos'
    expect(page).to have_content order1.code
    expect(page).not_to have_content order2.code
    expect(page).to have_content order3.code
  end

  it 'e visita um pedido' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')    
    supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: Marvel Costumes LTDA"
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
  end

  it 'e não visita pedidos de outros usuários' do
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
    visit order_path(order.id)

    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a esse pedido'

  end

end