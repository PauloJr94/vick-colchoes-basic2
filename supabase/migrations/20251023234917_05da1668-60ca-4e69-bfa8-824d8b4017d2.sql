-- Inserir produtos de exemplo

-- Colchões
INSERT INTO public.products (name, description, price, discount, category_id, image_url, is_featured) VALUES
(
  'Colchão Fashion Standard',
  'Colchão solteiro (14 x 188 x 88) com tecnologia de molas ensacadas e espuma de alta densidade',
  590.00,
  28,
  (SELECT id FROM public.categories WHERE name = 'Colchões' LIMIT 1),
  'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800',
  false
),
(
  'Colchão Pró Saúde Superpocket',
  'Colchão queen (25 x 198 x 158) com sistema Superpocket de molas independentes',
  2800.00,
  25,
  (SELECT id FROM public.categories WHERE name = 'Colchões' LIMIT 1),
  'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&w=800',
  true
),
(
  'Colchão Bellona',
  'Colchão casal (31 x 188 x 138) com tecnologia viscoelástica',
  5908.00,
  44,
  (SELECT id FROM public.categories WHERE name = 'Colchões' LIMIT 1),
  'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=800',
  true
),
(
  'Colchão Absolut Hybrid',
  'Colchão casal (31 x 188 x 138) com camadas híbridas de espuma e molas',
  4295.86,
  20,
  (SELECT id FROM public.categories WHERE name = 'Colchões' LIMIT 1),
  'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800',
  true
),
(
  'Colchão Liberty',
  'Colchão casal (31 x 188 x 138) com design ergonômico',
  2550.00,
  34,
  (SELECT id FROM public.categories WHERE name = 'Colchões' LIMIT 1),
  'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800',
  false
),
(
  'Colchão Fashion Firm',
  'Colchão solteiro (14 x 188 x 88) com firmeza extra',
  419.00,
  25,
  (SELECT id FROM public.categories WHERE name = 'Colchões' LIMIT 1),
  'https://images.unsplash.com/photo-1540574163026-643ea20ade25?auto=format&fit=crop&w=800',
  false
);

-- Conjuntos
INSERT INTO public.products (name, description, price, discount, category_id, image_url, is_featured) VALUES
(
  'Conjunto Box Casal Fashion',
  'Conjunto completo com colchão + box casal',
  890.00,
  35,
  (SELECT id FROM public.categories WHERE name = 'Conjuntos' LIMIT 1),
  'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=800',
  true
),
(
  'Conjunto Box Queen Premium',
  'Conjunto premium queen size com colchão de molas ensacadas',
  3200.00,
  28,
  (SELECT id FROM public.categories WHERE name = 'Conjuntos' LIMIT 1),
  'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=800',
  true
);

-- Bases
INSERT INTO public.products (name, description, price, discount, category_id, image_url, is_featured) VALUES
(
  'Base Box Casal Standard',
  'Base box casal em madeira maciça com tecido de alta durabilidade',
  450.00,
  20,
  (SELECT id FROM public.categories WHERE name = 'Bases' LIMIT 1),
  'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?auto=format&fit=crop&w=800',
  false
),
(
  'Base Box Queen Luxo',
  'Base box queen com sistema de ventilação e acabamento premium',
  890.00,
  15,
  (SELECT id FROM public.categories WHERE name = 'Bases' LIMIT 1),
  'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?auto=format&fit=crop&w=800',
  false
);

-- Travesseiros
INSERT INTO public.products (name, description, price, discount, category_id, image_url, is_featured) VALUES
(
  'Travesseiro Viscoelástico',
  'Travesseiro com espuma viscoelástica para alinhamento cervical perfeito',
  120.00,
  30,
  (SELECT id FROM public.categories WHERE name = 'Travesseiros' LIMIT 1),
  'https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?auto=format&fit=crop&w=800',
  false
),
(
  'Travesseiro de Plumas',
  'Travesseiro macio com enchimento de plumas naturais',
  85.00,
  25,
  (SELECT id FROM public.categories WHERE name = 'Travesseiros' LIMIT 1),
  'https://images.unsplash.com/photo-1586075010923-2dd4570fb338?auto=format&fit=crop&w=800',
  false
);