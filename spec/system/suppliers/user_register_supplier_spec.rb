require 'rails_helper'

describe 'Usuário cadastra um novo fornecedor' do
  it 'a partir da tela inicial' do
    visit(root_path)
    click_on 'Cadastrar Fornecedor'

    expect(page).to have_field('Nome fantasia')
    expect(page).to have_field('Razão social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Email')
    expect(page).to have_field('Telefone')
  end

  it 'com sucesso' do
    visit(root_path)
    click_on 'Cadastrar Fornecedor'

    fill_in 'Nome fantasia', with: 'Atacadão Big Big'
    fill_in 'Razão social', with: 'Supermercado Distribuições LTDA'
    fill_in 'CNPJ', with: '11222333444455'
    fill_in 'Endereço', with: 'Rua dos Bobos, 000'
    fill_in 'Estado', with: 'MG'
    fill_in 'Cidade', with: 'Belo Horizonte'
    fill_in 'Email', with: 'bigbig@email.com'
    fill_in 'Telefone', with: '5537999229922'
    click_on 'Enviar'    

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso'
    expect(page).to have_content 'Supermercado Distribuições LTDA'
    expect(page).to have_content 'Nome fantasia: Atacadão Big Big'
  end

  it 'com dados incompletos' do
    visit(root_path)
    click_on 'Cadastrar Fornecedor'

    fill_in 'Nome fantasia', with: ''
    fill_in 'Razão social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'
    
    
    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
    
  end

  it 'com CPNJ inválido' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
      registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
      city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')

    visit(root_path)
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome fantasia', with: 'Atacadão Big Big'
    fill_in 'Razão social', with: 'Supermercado Distribuições LTDA'
    fill_in 'CNPJ', with: '1122334455667' # menos de 14 caracteres
    fill_in 'Endereço', with: 'Rua dos Bobos, 000'
    fill_in 'Estado', with: 'MG'
    fill_in 'Cidade', with: 'Belo Horizonte'
    fill_in 'Email', with: 'bigbig@email.com'
    fill_in 'Telefone', with: '5537999229922'
    click_on 'Enviar'

    expect(page).to have_content 'CNPJ não possui o tamanho esperado (14 caracteres)'
  end

  it 'com CNPJ em uso' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
      registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
      city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')

    visit(root_path)
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome fantasia', with: 'Atacadão Big Big'
    fill_in 'Razão social', with: 'Supermercado Distribuições LTDA'
    fill_in 'CNPJ', with: '11222333444455' # CNPJ em uso
    fill_in 'Endereço', with: 'Rua dos Bobos, 000'
    fill_in 'Estado', with: 'MG'
    fill_in 'Cidade', with: 'Belo Horizonte'
    fill_in 'Email', with: 'bigbig@email.com'
    fill_in 'Telefone', with: '5537999229922'
    click_on 'Enviar'

    expect(page).to have_content 'CNPJ já está em uso'
  end
end