require 'rails_helper'

describe 'usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'
    
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '123456')
    Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
      adress: 'Avenida de Maceio, 500', cep: '28539-000', description:'descricao maceio')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')
    
    Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
        registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
        city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
      registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
      city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')
    
    
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Supermercado Distribuições LTDA'
    expect(page).to have_content 'Usuário Responsável: Sergio | sergio@email.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Maceio'
    expect(page).not_to have_content 'Marvel Costumes LTDA'

  end
end