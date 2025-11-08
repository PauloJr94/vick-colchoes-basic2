-- Create enum for roles
CREATE TYPE public.app_role AS ENUM ('admin', 'user');

-- Create user_roles table
CREATE TABLE public.user_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  role app_role NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  UNIQUE (user_id, role)
);

-- Enable RLS
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- Migrate existing role data from profiles to user_roles
INSERT INTO public.user_roles (user_id, role)
SELECT id, role::app_role
FROM public.profiles
WHERE role IS NOT NULL;

-- Create security definer function to check roles
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role app_role)
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles
    WHERE user_id = _user_id AND role = _role
  )
$$;

-- Create function to check if current user is admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT public.has_role(auth.uid(), 'admin'::app_role)
$$;

-- RLS policy for user_roles (admins can see all, users can see their own)
CREATE POLICY "Usuários podem ver suas próprias roles"
ON public.user_roles
FOR SELECT
USING (auth.uid() = user_id OR public.is_admin());

-- Only admins can insert/update/delete roles
CREATE POLICY "Apenas admins podem gerenciar roles"
ON public.user_roles
FOR ALL
USING (public.is_admin())
WITH CHECK (public.is_admin());

-- Update existing RLS policies to use the new has_role function
DROP POLICY IF EXISTS "Apenas admins podem gerenciar banners" ON public.banners;
CREATE POLICY "Apenas admins podem gerenciar banners"
ON public.banners
FOR ALL
USING (public.is_admin())
WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Apenas admins podem criar categorias" ON public.categories;
CREATE POLICY "Apenas admins podem criar categorias"
ON public.categories
FOR INSERT
WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Apenas admins podem criar produtos" ON public.products;
CREATE POLICY "Apenas admins podem criar produtos"
ON public.products
FOR INSERT
WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS "Apenas admins podem atualizar produtos" ON public.products;
CREATE POLICY "Apenas admins podem atualizar produtos"
ON public.products
FOR UPDATE
USING (public.is_admin())
WITH CHECK (public.is_admin());

-- Add delete policy for products
CREATE POLICY "Apenas admins podem deletar produtos"
ON public.products
FOR DELETE
USING (public.is_admin());

DROP POLICY IF EXISTS "Apenas admins podem atualizar configurações" ON public.settings;
CREATE POLICY "Apenas admins podem atualizar configurações"
ON public.settings
FOR UPDATE
USING (public.is_admin())
WITH CHECK (public.is_admin());

-- Add stock column to products table
ALTER TABLE public.products ADD COLUMN IF NOT EXISTS stock INTEGER DEFAULT 0;