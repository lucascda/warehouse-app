require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')    
    supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    visit edit_order_path(order)
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')    
    supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    supplier2 = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
          registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'

    fill_in 'Data Prevista de Entrega', with: '07/06/2022'
    select 'Supermercado Distribuições LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'    
    expect(page).to have_content "Fornecedor: Supermercado Distribuições LTDA"
    expect(page).to have_content "Data Prevista de Entrega: 07/06/2022"
  end

  it 'caso seja o responsável' do
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
    visit edit_order_path(order)

    expect(current_path).to eq root_path
  end
end