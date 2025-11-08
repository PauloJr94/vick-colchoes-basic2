-- Criar tabela de perfis de usuário
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  name TEXT,
  role TEXT DEFAULT 'user' CHECK (role IN ('user', 'admin')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Políticas para profiles
CREATE POLICY "Usuários podem ver seu próprio perfil"
  ON public.profiles FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Usuários podem atualizar seu próprio perfil"
  ON public.profiles FOR UPDATE
  USING (auth.uid() = id);

-- Criar tabela de categorias
CREATE TABLE IF NOT EXISTS public.categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  description TEXT,
  icon_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS para categories
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

-- Políticas para categories (público pode ver)
CREATE POLICY "Todos podem ver categorias"
  ON public.categories FOR SELECT
  USING (true);

CREATE POLICY "Apenas admins podem criar categorias"
  ON public.categories FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Criar tabela de produtos
CREATE TABLE IF NOT EXISTS public.products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  description TEXT,
  price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  discount NUMERIC(5,2) DEFAULT 0 CHECK (discount >= 0 AND discount <= 100),
  category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
  image_url TEXT,
  is_featured BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS para products
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

-- Políticas para products
CREATE POLICY "Todos podem ver produtos"
  ON public.products FOR SELECT
  USING (true);

CREATE POLICY "Apenas admins podem criar produtos"
  ON public.products FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

CREATE POLICY "Apenas admins podem atualizar produtos"
  ON public.products FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Criar tabela de banners promocionais
CREATE TABLE IF NOT EXISTS public.banners (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  subtitle TEXT,
  image_url TEXT,
  link_url TEXT,
  active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS para banners
ALTER TABLE public.banners ENABLE ROW LEVEL SECURITY;

-- Políticas para banners
CREATE POLICY "Todos podem ver banners ativos"
  ON public.banners FOR SELECT
  USING (active = true);

CREATE POLICY "Apenas admins podem gerenciar banners"
  ON public.banners FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Criar tabela de configurações da loja
CREATE TABLE IF NOT EXISTS public.settings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_name TEXT NOT NULL,
  slogan TEXT,
  whatsapp TEXT,
  email TEXT,
  address TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

-- Habilitar RLS para settings
ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;

-- Políticas para settings
CREATE POLICY "Todos podem ver configurações"
  ON public.settings FOR SELECT
  USING (true);

CREATE POLICY "Apenas admins podem atualizar configurações"
  ON public.settings FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Trigger para atualizar updated_at em products
CREATE TRIGGER update_products_updated_at
  BEFORE UPDATE ON public.products
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger para atualizar updated_at em settings
CREATE TRIGGER update_settings_updated_at
  BEFORE UPDATE ON public.settings
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger para criar perfil automaticamente quando usuário se registra
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, name, role)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', NEW.email),
    'user'
  );
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- Criar bucket de storage para imagens de produtos
INSERT INTO storage.buckets (id, name, public)
VALUES ('products', 'products', true)
ON CONFLICT (id) DO NOTHING;

-- Políticas de storage para produtos
CREATE POLICY "Imagens de produtos são públicas"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'products');

CREATE POLICY "Apenas admins podem fazer upload de imagens"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'products' AND
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Inserir configurações padrão da loja
INSERT INTO public.settings (store_name, slogan, whatsapp, email, address)
VALUES (
  'V Colchões',
  'Sua melhor noite de sono começa aqui',
  '(81) 99999-9999',
  'contato@vcolchoes.com.br',
  'Recife - PE, Brasil'
)
ON CONFLICT DO NOTHING;

-- Inserir categorias padrão
INSERT INTO public.categories (name, description) VALUES
  ('Colchões', 'Conforto e qualidade para suas noites'),
  ('Bases', 'Bases robustas e duráveis'),
  ('Conjuntos', 'Kits completos com desconto especial'),
  ('Cabeceiras', 'Estilo e elegância para seu quarto'),
  ('Roupas de Cama', 'Lençóis, fronhas e edredons'),
  ('Travesseiros', 'Conforto perfeito para sua cabeça'),
  ('Acessórios', 'Complementos para seu descanso'),
  ('Móveis', 'Móveis para completar seu quarto')
ON CONFLICT (name) DO NOTHING;