require 'rails_helper'

describe 'usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
      registration_number: '11223344556677', full_adress: 'Rua dos Bobos, 000',
      city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    
    visit(root_path)
    click_on 'Fornecedores'
    click_on 'Supermercado Distribuições LTDA'
    click_on 'Editar'
        
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Razão social', with: 'Supermercado Distribuições LTDA')
    expect(page).to have_field('Nome fantasia', with: 'Atacadão Big Big')
    expect(page).to have_field('CNPJ', with: '11223344556677')
    expect(page).to have_field('Endereço', with: 'Rua dos Bobos, 000')
    expect(page).to have_field('Cidade', with: 'Belo Horizonte')
    expect(page).to have_field('Estado', with: 'MG')
    expect(page).to have_field('Email', with: 'bigbig@email.com')
    expect(page).to have_field('Telefone', with: '5537999229922')



  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
      registration_number: '11223344556677', full_adress: 'Rua dos Bobos, 000',
      city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    
    visit(root_path)
    click_on 'Fornecedores'
    click_on 'Supermercado Distribuições LTDA'
    click_on 'Editar'

    fill_in 'Razão social', with: 'Super Distr. LTDA'
    fill_in 'Nome fantasia', with: 'Super Big Big'
    fill_in 'CNPJ', with: '22223344556677'
    fill_in 'Endereço', with: 'Rua do Big Big, 123'
    fill_in 'Cidade', with: 'BH'
    fill_in 'Estado', with: 'Minas Gerais'
    fill_in 'Email', with: 'fulano@bigbig.com'
    fill_in 'Telefone', with: '5531999999898'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'CNPJ: 22223344556677'
    expect(page).to have_content 'Endereço: Rua do Big Big, 123'
    expect(page).to have_content 'Cidade: BH'
    expect(page).to have_content 'Estado: Minas Gerais'
    expect(page).to have_content 'Email: fulano@bigbig.com'
    expect(page).to have_content 'Telefone: 5531999999898'
  end

  it 'e mantém campos obrigatórios' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
      registration_number: '11223344556677', full_adress: 'Rua dos Bobos, 000',
      city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    
    visit(root_path)
    click_on 'Fornecedores'
    click_on 'Supermercado Distribuições LTDA'
    click_on 'Editar'
    
    fill_in 'Razão social', with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor não atualizado'
    
  end
end