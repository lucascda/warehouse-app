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