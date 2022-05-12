require 'rails_helper'

describe 'Usuário visualiza fornecedores' do
  it 'a partir do menu inicial' do
    visit(root_path)
    click_on('Fornecedores')
    expect(current_path).to eq suppliers_path   
  end

  it 'mas não vê fornecedores cadastrados' do
    visit(root_path)
    click_on('Fornecedores')
    expect(page).to have_content('Não existem fornecedores cadastrados')
  end

  it 'vê fornecedores cadastrados' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
                                registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
                                city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    supplier2 = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
      registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
      city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')
    visit(root_path)
    click_on('Fornecedores')
    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'Supermercado Distribuições LTDA'
    expect(page).to have_content 'Nome fantasia: Atacadão Big Big'
    expect(page).to have_content 'Marvel Costumes LTDA'
    expect(page).to have_content 'Nome fantasia: Mundo das Fantasias'   

  end

  it 'e volta pra página inicial' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
                                registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
                                city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    visit(root_path)
    click_on('Fornecedores')
    click_on('Voltar')
    expect(current_path).to eq root_path

  end
end