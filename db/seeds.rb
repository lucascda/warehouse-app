# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
w = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
    area: 100_000, adress: 'Avenida do Aeroporto, 1000', cep: '15000-000',
    description: 'Galpão destinado para cargas internacionais')
w2 = Warehouse.create(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro',
    area: 80_000, adress: 'Endereço do aeroporto, 589', cep: '16020-000',
    description: 'Galpão destinado para cargas nacionais')
    
supplier = Supplier.create!(corporate_name: 'Supermercado Distribuições LTDA', brand_name: 'Atacadão Big Big',
        registration_number: '11222333444455', full_adress: 'Rua dos Bobos, 000',
        city: 'Belo Horizonte', state: 'MG', email: 'bigbig@email.com', phone_number: '5537999229922')
supplier2 = Supplier.create!(corporate_name: 'Marvel Costumes LTDA', brand_name: 'Mundo das Fantasias',
registration_number: '11222333444466', full_adress: 'Rua das Fantasias, 123',
city: 'São Paulo', state: 'SP', email: 'mundomagico@email.com', phone_number: '5511999339933')