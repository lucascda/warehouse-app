require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                                 adress: 'Avenida de Maceio, 500', cep: '28539-000',
                                 description:'descricao maceio')
    # Act
    visit(root_path)
    click_on 'Maceio'
    click_on 'Editar'
    # Assert
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field('Nome', with: 'Maceio')
    expect(page).to have_field('Código', with: 'MCZ')
    expect(page).to have_field('Cidade', with: 'Maceio')
    expect(page).to have_field('Área', with: '50000')
    expect(page).to have_field('Endereço', with: 'Avenida de Maceio, 500')
    expect(page).to have_field('CEP', with: '28539-000')
    expect(page).to have_field('Descrição', with: 'descricao maceio')
  end

  it 'com sucesso' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
                                  adress: 'Avenida de Maceio, 500', cep: '28539-000',
                                  description:'descricao maceio')
    # Act
    visit(root_path)
    click_on 'Maceio'
    click_on 'Editar'

    fill_in 'Nome', with: 'Galpão de Maceio'
    fill_in 'Código', with: 'MCZ2'
    fill_in 'Cidade', with: 'Maceió'
    fill_in 'Área', with: '150000'
    fill_in 'Endereço', with: 'Uma avenida de Maceió, 100'
    fill_in 'CEP', with: '28000-123'
    fill_in 'Descrição', with: 'Descrição alterada de Maceió'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Galpão MCZ2'
    expect(page).to have_content 'Nome: Galpão de Maceio'
    expect(page).to have_content 'Cidade: Maceió'
    expect(page).to have_content 'Área: 150000'
    expect(page).to have_content 'Endereço: Uma avenida de Maceió, 100'
    expect(page).to have_content 'CEP: 28000-123'
    expect(page).to have_content 'Descrição alterada de Maceió'
  end

  it 'e mantém campos obrigatórios' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
      adress: 'Avenida de Maceio, 500', cep: '28539-000',
      description:'descricao maceio')
    # Act
    visit(root_path)
    click_on 'Maceio'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Não foi possível atualizar o galpão'    
  end
end