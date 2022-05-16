require 'rails_helper'

describe 'usuário cadastra um novo modelo de produto' do
  it 'a partir do menu inicial' do
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar modelo de produto'
    expect(current_path).to eq new_product_model_path 
  end

  it 'com sucesso' do
    my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                  registration_number: '11112222333344',full_adress: 'Av Samsung, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    other_supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
                                     registration_number: '07317108000151', full_adress: 'Av Ibirapuera, 300',
                                     city: 'São Paulo',state: 'SP', email: 'contato@lg.com.br')
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    login_as(user)
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar modelo de produto'
   
    fill_in 'Nome', with: 'TV 32'
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: '70'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'TV32-SAMS-UMG1-23456'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'
    
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'Peso: 8000 g'
    expect(page).to have_content 'Dimensão: 70cm x 45cm x 10cm'
    expect(page).to have_content 'SKU: TV32-SAMS-UMG1-23456'
    expect(page).to have_content 'Fornecedor: Samsung'

    
  end

  it 'deve preencher todos os campos' do
    my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                  registration_number: '11112222333344',full_adress: 'Av Samsung, 1000',
                                  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    
    user = User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: 10000
    fill_in 'SKU', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
  end


end