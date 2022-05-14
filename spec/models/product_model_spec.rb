require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name cant be blank' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                      registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
                                      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10,
                             sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        expect(pm).not_to be_valid
      end
  
      it 'weight cant be blank' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                      registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
                                      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10,
                              sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        expect(pm).not_to be_valid
      end
  
      it 'width cant be blank' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
          registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10,
        sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        expect(pm).not_to be_valid
      end
  
      it 'height cant be blank' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
          registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10,
        sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        expect(pm).not_to be_valid
      end
  
      it 'depth cant be blank' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
          registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '',
        sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        expect(pm).not_to be_valid
      end
  
      it 'sku cant be blank' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
          registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
        sku: '', supplier: my_supplier)
        expect(pm).not_to be_valid
      end
  
      it 'supplier cant be blank' do
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
        sku: 'TV32-SAMS-UMG1-23456', supplier: nil)
        expect(pm).not_to be_valid
      end
    end

    context 'uniqueness' do
      it 'sku must be unique' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
          registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
          pm1 = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
            sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
          pm2 = ProductModel.new(name: 'TV 40', weight: 8500, width: 75, height: 45, depth: 12,
                                sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        

        expect(pm2).not_to be_valid
      end
      
      
    end

    context 'length' do
      it 'sku must be 20 characters long' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
          registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
          city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
          sku: 'TV32-SAMS-UMG1', supplier: my_supplier)
        
        expect(pm).not_to be_valid
      end
    end

    context 'right values' do
      it 'weight and dimensions must be greater than zero' do
        my_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
                                      registration_number: '11112222333344', full_adress: 'Av Samsung, 1000',
                                      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 0 , height: -2, depth: 10,
          sku: 'TV32-SAMS-UMG1-23456', supplier: my_supplier)
        
        expect(pm).not_to be_valid

      end
    end
 
  end
  
end
