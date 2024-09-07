-- mm-product/db/mm-product.sql

-- Create the marketmaster database
CREATE DATABASE marketmaster;

\connect marketmaster;

-- Create a table for product categories
CREATE TABLE IF NOT EXISTS category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Optionally, add indexes for commonly queried columns
CREATE INDEX IF NOT EXISTS idx_categories_id ON category(id);
CREATE INDEX IF NOT EXISTS idx_categories_name ON category(name);

-- Create a table for products
CREATE TABLE IF NOT EXISTS product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    brand VARCHAR(255),
    category INTEGER NOT NULL REFERENCES category(id),
    suggestedprice DECIMAL(10, 2) NOT NULL,
    imageurl VARCHAR(255)
);

-- Optionally, add indexes for commonly queried columns
CREATE INDEX IF NOT EXISTS idx_products_id ON product(id);
CREATE INDEX IF NOT EXISTS idx_products_name ON product(name);
CREATE INDEX IF NOT EXISTS idx_products_brand ON product(brand);
CREATE INDEX IF NOT EXISTS idx_products_description ON product(description);
CREATE INDEX IF NOT EXISTS idx_products_price ON product(suggestedprice);

-- mm-product/db/mm-product-data.sql

-- Insert categories
INSERT INTO category (name) VALUES
('Mercearia'),
('Massas'),
('Limpeza'),
('Frigorífico'),
('Laticínios'),
('Frutas e Verduras'),
('Bebidas'),
('Padaria e Confeitaria'),
('Higiene Pessoal'),
('Bazar e Utilidades'),
('Congelados'),
('Pet Shop'),
('Peixaria'),
('Doces e Sobremesas'),
('Especiarias e Temperos');

-- Insert products for each category with various brands and descriptions
INSERT INTO product (name, description, brand, category, suggestedprice, imageurl) VALUES
-- Mercearia
('Arroz Branco', 'Arroz branco polido - 1kg', 'Marca A', 1, 5.49, 'http://example.com/arroz_a.jpg'),
('Arroz Integral', 'Arroz integral natural - 1kg', 'Marca B', 1, 6.10, 'http://example.com/arroz_b.jpg'),
('Açúcar Refinado', 'Açúcar branco refinado - 1kg', 'Marca C', 1, 3.20, 'http://example.com/acucar.jpg'),
('Açúcar Mascavo', 'Açúcar mascavo natural - 500g', 'Marca D', 1, 4.50, 'http://example.com/mascavo.jpg'),
('Farinha de Trigo', 'Farinha de trigo especial - 1kg', 'Marca E', 1, 2.80, 'http://example.com/farinha.jpg'),
('Óleo de Soja', 'Óleo de soja refinado - 900ml', 'Marca F', 1, 5.40, 'http://example.com/oleo.jpg'),

-- Massas
('Macarrão Espaguete', 'Espaguete - 500g', 'Marca A', 2, 3.99, 'http://example.com/espaguete_a.jpg'),
('Macarrão Penne', 'Penne rigate - 500g', 'Marca B', 2, 4.15, 'http://example.com/penne.jpg'),
('Lasanha', 'Massa para lasanha - 500g', 'Marca C', 2, 5.75, 'http://example.com/lasanha.jpg'),
('Macarrão Fusilli', 'Fusilli tricolor - 500g', 'Marca D', 2, 4.50, 'http://example.com/fusilli.jpg'),
('Macarrão Integral', 'Macarrão integral - 500g', 'Marca E', 2, 4.90, 'http://example.com/integral.jpg'),
('Canelone', 'Massa para canelone - 300g', 'Marca F', 2, 6.20, 'http://example.com/canelone.jpg'),

-- Limpeza
('Detergente Líquido', 'Detergente neutro - 500ml', 'Marca A', 3, 1.99, 'http://example.com/detergente_a.jpg'),
('Água Sanitária', 'Água sanitária - 1L', 'Marca B', 3, 3.45, 'http://example.com/agua.jpg'),
('Desinfetante', 'Desinfetante eucalipto - 1L', 'Marca C', 3, 4.20, 'http://example.com/desinfetante.jpg'),
('Sabão em Pó', 'Sabão em pó - 1kg', 'Marca D', 3, 7.60, 'http://example.com/sabao.jpg'),
('Limpador Multiuso', 'Multiuso cítrico - 500ml', 'Marca E', 3, 5.25, 'http://example.com/multiuso.jpg'),
('Esponja de Limpeza', 'Esponja dupla face - 3 unid', 'Marca F', 3, 2.80, 'http://example.com/esponja.jpg'),

-- Frigorífico
('Filé de Peito de Frango', 'Peito de frango sem osso - 1kg', 'Marca A', 4, 14.90, 'http://example.com/frango.jpg'),
('Carne Moída', 'Carne moída de primeira - 1kg', 'Marca B', 4, 22.40, 'http://example.com/carne_moida.jpg'),
('Linguiça Toscana', 'Linguiça toscana - 1kg', 'Marca C', 4, 19.70, 'http://example.com/linguica.jpg'),
('Picanha', 'Picanha bovina - 1kg', 'Marca D', 4, 52.30, 'http://example.com/picanha.jpg'),
('Bacon Fatiado', 'Bacon premium fatiado - 500g', 'Marca E', 4, 17.85, 'http://example.com/bacon.jpg'),
('Salsicha', 'Salsicha hot dog - 500g', 'Marca F', 4, 8.50, 'http://example.com/salsicha.jpg'),

-- Laticínios
('Leite Integral', 'Leite integral - 1L', 'Marca A', 5, 3.50, 'http://example.com/leite_int.jpg'),
('Queijo Mozzarella', 'Queijo mozzarella - 500g', 'Marca B', 5, 8.95, 'http://example.com/mozzarella.jpg'),
('Iogurte Natural', 'Iogurte natural - 200g', 'Marca C', 5, 1.80, 'http://example.com/iogurte.jpg'),
('Manteiga com Sal', 'Manteiga com sal - 200g', 'Marca D', 5, 5.75, 'http://example.com/manteiga.jpg'),
('Creme de Leite', 'Creme de leite - 200g', 'Marca E', 5, 2.50, 'http://example.com/creme.jpg'),
('Requeijão Cremoso', 'Requeijão cremoso - 200g', 'Marca F', 5, 4.40, 'http://example.com/requeijao.jpg'),

-- Frutas e Verduras
('Maçã', 'Maçã vermelha fresca - 1kg', 'Marca A', 6, 4.99, 'http://example.com/maca.jpg'),
('Banana', 'Banana prata - 1kg', 'Marca B', 6, 3.50, 'http://example.com/banana.jpg'),
('Tomate', 'Tomate italiano - 1kg', 'Marca C', 6, 5.20, 'http://example.com/tomate.jpg'),
('Cenoura', 'Cenoura - 1kg', 'Marca D', 6, 2.80, 'http://example.com/cenoura.jpg'),
('Alface', 'Alface crespa - unidade', 'Marca E', 6, 1.99, 'http://example.com/alface.jpg'),
('Espinafre', 'Espinafre - maço', 'Marca F', 6, 3.25, 'http://example.com/espinafre.jpg'),

-- Bebidas
('Coca-Cola', 'Refrigerante de cola - 2L', 'Coca-Cola', 7, 6.99, 'http://example.com/coca_cola.jpg'),
('Suco de Laranja', 'Suco natural de laranja - 1L', 'Natural One', 7, 8.00, 'http://example.com/suco_laranja.jpg'),
('Água Mineral', 'Água mineral sem gás - 500ml', 'Crystal', 7, 1.50, 'http://example.com/agua_mineral.jpg'),
('Cerveja Pilsen', 'Cerveja Pilsen - 350ml', 'Heineken', 7, 2.99, 'http://example.com/cerveja_heineken.jpg'),
('Vinho Tinto', 'Vinho Tinto Suave - 750ml', 'Sangue de Boi', 7, 12.50, 'http://example.com/vinho_tinto.jpg'),
('Chá Mate', 'Chá mate gelado - 1.5L', 'Leão', 7, 4.20, 'http://example.com/cha_mate.jpg'),

-- Padaria e Confeitaria
('Pão Francês', 'Pão francês fresco - 50g cada', 'Padaria Sol', 8, 0.25, 'http://example.com/pao_frances.jpg'),
('Bolo de Chocolate', 'Bolo de chocolate - 500g', 'Padaria Sol', 8, 20.00, 'http://example.com/bolo_chocolate.jpg'),
('Croissant', 'Croissant manteiga - unidade', 'Padaria Lua', 8, 3.50, 'http://example.com/croissant.jpg'),
('Torta de Limão', 'Torta de limão - 100g', 'Confeitaria Doce', 8, 6.75, 'http://example.com/torta_limao.jpg'),
('Pão de Queijo', 'Pão de queijo - pacote com 6', 'Forno de Minas', 8, 7.90, 'http://example.com/pao_queijo.jpg'),
('Donuts', 'Donuts com cobertura de chocolate - unidade', 'Padaria Estrela', 8, 4.50, 'http://example.com/donuts.jpg'),

-- Higiene Pessoal
('Shampoo', 'Shampoo anticaspa - 400ml', 'Clear Men', 9, 19.90, 'http://example.com/shampoo.jpg'),
('Sabonete', 'Sabonete antibacteriano - 90g', 'Dove', 9, 2.49, 'http://example.com/sabonete.jpg'),
('Pasta de Dente', 'Pasta de dente clareadora - 90g', 'Colgate', 9, 8.99, 'http://example.com/pasta_dente.jpg'),
('Desodorante', 'Desodorante spray - 150ml', 'Rexona', 9, 12.99, 'http://example.com/desodorante.jpg'),
('Absorvente', 'Absorvente com abas - pacote com 8', 'Always', 9, 6.50, 'http://example.com/absorvente.jpg'),
('Papel Higiênico', 'Papel higiênico folha dupla - 4 rolos', 'Neve', 9, 4.75, 'http://example.com/papel_higienico.jpg'),

-- Bazar e Utilidades
('Pilha AAA', 'Pilhas alcalinas AAA - pacote com 4', 'Duracell', 10, 9.90, 'http://example.com/pilhas.jpg'),
('Lâmpada LED', 'Lâmpada LED 9W - branca', 'Philips', 10, 6.99, 'http://example.com/lampada_led.jpg'),
('Vassoura', 'Vassoura de cerdas sintéticas', 'Bettanin', 10, 12.90, 'http://example.com/vassoura.jpg'),
('Panela de Pressão', 'Panela de pressão 4.5L - alumínio', 'Tramontina', 10, 89.90, 'http://example.com/panela_pressao.jpg'),
('Jogo de Talheres', 'Conjunto de talheres inox - 24 peças', 'Tramontina', 10, 98.00, 'http://example.com/talheres.jpg'),
('Garrafa Térmica', 'Garrafa térmica 1L - aço inox', 'Termolar', 10, 59.90, 'http://example.com/garrafa_termica.jpg'),

-- Congelados
('Pizza Congelada', 'Pizza de mussarela - 400g', 'Sadia', 11, 14.99, 'http://example.com/pizza.jpg'),
('Hambúrguer Congelado', 'Hambúrguer bovino - pacote com 8', 'Seara', 11, 15.90, 'http://example.com/hamburguer.jpg'),
('Lasanha Congelada', 'Lasanha à bolonhesa - 1kg', 'Perdigão', 11, 12.00, 'http://example.com/lasanha.jpg'),
('Pão de Queijo Congelado', 'Pão de queijo - pacote com 20', 'Forno de Minas', 11, 19.50, 'http://example.com/pao_queijo_congelado.jpg'),
('Sorvete', 'Sorvete de creme - 2L', 'Kibon', 11, 18.99, 'http://example.com/sorvete.jpg'),
('Nuggets de Frango', 'Nuggets de frango - 300g', 'Sadia', 11, 8.99, 'http://example.com/nuggets.jpg'),

('Ração para Cães', 'Ração seca para cães adultos - 15kg', 'Pedigree', 12, 149.99, 'http://example.com/racao_caes.jpg'),
('Areia Sanitária', 'Areia sanitária para gatos - 10kg', 'Pipicat', 12, 21.90, 'http://example.com/areia_sanitaria.jpg'),
('Osso Mordedor', 'Mordedor em forma de osso para cães', 'Kong', 12, 19.99, 'http://example.com/osso_mordedor.jpg'),
('Shampoo para Pets', 'Shampoo neutro para cães e gatos - 500ml', 'Pet Clean', 12, 25.75, 'http://example.com/shampoo_pets.jpg'),
('Coleira Antipulgas', 'Coleira antipulgas para cães de médio porte', 'Seresto', 12, 79.90, 'http://example.com/coleira_antipulgas.jpg'),
('Ração para Peixes', 'Ração em flocos para peixes ornamentais - 100g', 'Tetra', 12, 12.50, 'http://example.com/racao_peixes.jpg'),

-- Peixaria
('Filé de Tilápia', 'Filé de tilápia fresco - 1kg', 'Frescatto', 13, 34.90, 'http://example.com/file_tilapia.jpg'),
('Salmão', 'Salmão inteiro fresco - 1kg', 'Noruega', 13, 59.99, 'http://example.com/salmao.jpg'),
('Camarão Rosa', 'Camarão rosa grande limpo - 500g', 'Marine', 13, 89.90, 'http://example.com/camarao_rosa.jpg'),
('Lula', 'Anéis de lula congelados - 500g', 'Oceanic', 13, 29.90, 'http://example.com/lula.jpg'),
('Bacalhau', 'Lombo de bacalhau dessalgado - 500g', 'Gomes da Costa', 13, 74.99, 'http://example.com/bacalhau.jpg'),
('Polvo', 'Polvo congelado - 500g', 'Seafood', 13, 49.90, 'http://example.com/polvo.jpg'),

-- Doces e Sobremesas
('Chocolate ao Leite', 'Barra de chocolate ao leite - 100g', 'Garoto', 14, 5.99, 'http://example.com/chocolate_leite.jpg'),
('Pudim', 'Pudim de leite condensado - 200g', 'Moça', 14, 6.90, 'http://example.com/pudim.jpg'),
('Gelatina', 'Gelatina de morango - pacote com 6', 'Royal', 14, 4.50, 'http://example.com/gelatina.jpg'),
('Biscoito Recheado', 'Biscoito recheado de chocolate - 140g', 'Oreo', 14, 2.99, 'http://example.com/biscoito_oreo.jpg'),
('Mousse de Maracujá', 'Mousse de maracujá pronto para consumo - 100g', 'Nestlé', 14, 3.99, 'http://example.com/mousse_maracuja.jpg'),
('Torta de Maçã', 'Torta de maçã caseira - 500g', 'Caseira', 14, 14.90, 'http://example.com/torta_maca.jpg'),

-- Especiarias e Temperos
('Curry', 'Curry em pó - 100g', 'Kitano', 15, 3.75, 'http://example.com/curry.jpg'),
('Noz-Moscada', 'Noz-moscada moída - 50g', 'McCormick', 15, 5.99, 'http://example.com/noz_moscada.jpg'),
('Canela em Pau', 'Canela em pau - 50g', 'Vitalin', 15, 4.25, 'http://example.com/canela_pau.jpg'),
('Colorau', 'Colorau para dar cor e sabor aos alimentos - 100g', 'Tempero Bom', 15, 1.99, 'http://example.com/colorau.jpg'),
('Pimenta do Reino', 'Pimenta do reino moída - 100g', 'Branca', 15, 6.50, 'http://example.com/pimenta_reino.jpg'),
('Orégano', 'Orégano desidratado - 30g', 'Sacciali', 15, 3.20, 'http://example.com/oregano.jpg');


