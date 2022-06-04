require 'rails_helper'

describe 'usuário busca por um pedido' do
  
  it 'a partir do menu' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    login_as(user)
    visit root_path

    within 'header nav' do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end

  end

  it 'e deve estar autenticado' do
    visit root_path
    within 'header nav' do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end

  end

  it 'e encontra um pedido' do
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
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: Marvel Costumes LTDA"
  end

  it 'e encontra múltiplos pedidos ' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    warehouse1 = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')
    warehouse2 = Warehouse.create!(name: 'Aeroporto Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        adress: 'Avenida do Rio, 1000', cep: '20000-000', description: 'uma descricao'  )
    supplier = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    order1 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU9875')
    order2 = Order.create!(user: user, warehouse: warehouse1, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')
    order3 = Order.create!(user: user, warehouse: warehouse2, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'
    
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content('GRU12345')
    expect(page).to have_content('GRU9875')
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).not_to have_content('SDU00000')
    expect(page).not_to have_content "Galpão Destino: SDU - Aeroporto Rio"


  end 
end