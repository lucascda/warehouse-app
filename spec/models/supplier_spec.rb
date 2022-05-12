require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate name is empty' do
        supplier = Supplier.new(corporate_name: '', brand_name: 'Atacadão Big Big',
          registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')

        expect(supplier).not_to be_valid
      end

      it 'false when brand_name is empty' do
        supplier = Supplier.new(corporate_name: 'Super LTDA', brand_name: '',
          registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
        
        expect(supplier).not_to be_valid 

      end

      it 'false when registration_number is empty' do
        supplier = Supplier.new(corporate_name: 'Super LTDA', brand_name: 'Atacadão Big Big',
          registration_number: '', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
        
        expect(supplier).not_to be_valid 
      end

      it 'false when email is empty' do
        supplier = Supplier.new(corporate_name: 'Super LTDA', brand_name: 'Atacadão Big Big',
          registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: '', phone_number: '5537999229922')
        
        expect(supplier).not_to be_valid 
      end

    end

    context 'uniqueness' do
      it 'false when registration_number is not unique' do
        supplier1 = Supplier.create(corporate_name: 'Super LTDA', brand_name: 'Atacadão Big Big',
          registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
        supplier2 = Supplier.new(corporate_name: 'Fármácia Skina', brand_name: 'Farmácia Mais Saúde',
          registration_number: '11222333444455', full_adress: 'Rua da Doença, 400',
          city: 'Belo Horizonte', state: 'MG', email: 'saude@email.com', phone_number: '5537999888877')
        
        expect(supplier2).not_to be_valid 
      end

    end

    context 'length' do
      it 'false when registration numbers length is not 14' do
        supplier = Supplier.new(corporate_name: 'Supermercado ltda', brand_name: 'Atacadão Big Big',
          registration_number: '111222333444', full_adress: 'Rua dos Bobos, 000',
          city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
        
        expect(supplier).not_to be_valid
      end
    end
  end
end
