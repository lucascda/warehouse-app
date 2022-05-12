require 'rails_helper'

describe 'usuário vê detalhes de um galpão' do
    it 'e vê informações adicionais' do
      # Arrange
      w = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')  
      # Act
      visit(root_path)
      click_on('Aeroporto SP') 
      # Assert
      expect(page).to have_content('Galpão GRU')
      expect(page).to have_content('Nome: Aeroporto SP')
      expect(page).to have_content('Cidade: Guarulhos')
      expect(page).to have_content('Área: 100000 m²')
      expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
      expect(page).to have_content('Galpão destinado para cargas internacionais')      
    end

    it 'e volta pra tela inicial' do
      # Arrange
      w = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
        area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais')  
      # Act
      visit(root_path)
      click_on 'Aeroporto SP'
      click_on 'Voltar'
      expect(current_path).to eq(root_path)  
      # Assert
    end
    
end