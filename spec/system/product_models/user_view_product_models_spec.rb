require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do
    visit root_path
    within 'nav' do
      click_on 'Modelos de Produtos'
    end
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    visit(root_path)
    click_on 'Entrar'
    fill_in 'Email', with: 'lucas@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
                                city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
                         sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15,
                         depth: 20, sku: 'SOU71-SAMSU-NOIZ7789', supplier: my_supplier)
    User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    visit(root_path)
    click_on 'Entrar'
    fill_in 'Email', with: 'lucas@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end    
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMS-UMG1-23456'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ7789'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    User.create!(name: 'Lucas', email: 'lucas@email.com', password: 'password')
    visit(root_path)
    click_on 'Entrar'
    fill_in 'Email', with: 'lucas@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Modelos de Produtos'
    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end
end