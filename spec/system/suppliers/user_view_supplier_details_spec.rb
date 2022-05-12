require 'rails_helper'

describe 'usuário vê detalhes de um fornecedor' do
  it 'e visualiza informações adicionais' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
                                registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
                                city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    
    visit(root_path)
    click_on 'Fornecedores'
    click_on 'Supermercado Distribuições LTDA'
    expect(page).to have_content 'Supermercado Distribuições LTDA'
    expect(page).to have_content 'Nome fantasia: Atacadão Big Big'
    expect(page).to have_content 'CNPJ: 11222333444455 '
    expect(page).to have_content 'Endereço: Rua dos Bobos, 000'
    expect(page).to have_content 'Cidade: Belo Horizonte Estado: MG'
    expect(page).to have_content 'Email: bigbig@email.com'
    expect(page).to have_content '5537999229922'

  end

  it 'e volta pra tela de fornecedores' do
    supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
                                registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
                                city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
    visit(root_path)
    click_on 'Fornecedores'
    click_on 'Supermercado Distribuições LTDA'
    click_on 'Voltar'
    expect(current_path).to eq suppliers_path

  end
end