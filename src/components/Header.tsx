import { ShoppingCart, Heart, User, Menu, MapPin, Phone, Mail } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useNavigate } from "react-router-dom";
import { useAdmin } from "@/hooks/useAdmin";
import logo from "@/assets/logo.jpg";

const Header = () => {
  const navigate = useNavigate();
  const { isAdmin } = useAdmin();

  return (
    <header className="sticky top-0 z-50 bg-background border-b border-border">
      {/* Top Bar */}
      <div className="bg-primary text-primary-foreground">
        <div className="container mx-auto px-4 py-2">
          <div className="flex flex-wrap items-center justify-between gap-2 text-sm">
            <div className="flex items-center gap-4">
              <a href="tel:+5581999999999" className="flex items-center gap-2 hover:text-accent transition-colors">
                <Phone className="h-3 w-3" />
                <span className="hidden sm:inline">(81) 99999-9999</span>
              </a>
              <a href="mailto:contato@vcolchoes.com.br" className="flex items-center gap-2 hover:text-accent transition-colors">
                <Mail className="h-3 w-3" />
                <span className="hidden md:inline">contato@vcolchoes.com.br</span>
              </a>
            </div>
            <div className="flex items-center gap-2">
              <MapPin className="h-3 w-3" />
              <span className="hidden sm:inline">Recife - PE</span>
            </div>
          </div>
        </div>
      </div>

      {/* Main Header */}
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between gap-4">
          {/* Logo */}
          <a href="/" className="flex items-center gap-2">
            <img src={logo} alt="V Colchões" className="h-12 w-12 rounded-full object-cover" />
            <div className="hidden sm:block">
              <h1 className="text-xl font-bold text-foreground">V Colchões</h1>
              <p className="text-xs text-muted-foreground">Sua melhor noite de sono</p>
            </div>
          </a>

          {/* Navigation */}
          <nav className="hidden lg:flex items-center gap-6">
            <a href="#ofertas" className="text-sm font-medium text-foreground hover:text-accent transition-colors">
              OFERTAS
            </a>
            <a href="#colchoes" className="text-sm font-medium text-foreground hover:text-accent transition-colors">
              Colchões
            </a>
            <a href="#bases" className="text-sm font-medium text-foreground hover:text-accent transition-colors">
              Bases
            </a>
            <a href="#conjuntos" className="text-sm font-medium text-foreground hover:text-accent transition-colors">
              Conjuntos
            </a>
            <a href="#contato" className="text-sm font-medium text-foreground hover:text-accent transition-colors">
              Contato
            </a>
          </nav>

          {/* Actions */}
          <div className="flex items-center gap-2">
            <Button
              variant="ghost"
              size="icon"
              className="hover:bg-accent/10"
              onClick={() => navigate(isAdmin ? '/admin/dashboard' : '/admin/login')}
              aria-label="Acessar painel administrativo"
            >
              <User className="h-5 w-5" />
            </Button>
            <Button variant="ghost" size="icon" className="hover:bg-accent/10">
              <Heart className="h-5 w-5" />
            </Button>
            <Button variant="ghost" size="icon" className="hover:bg-accent/10 relative">
              <ShoppingCart className="h-5 w-5" />
              <span className="absolute -top-1 -right-1 bg-accent text-accent-foreground text-xs rounded-full h-4 w-4 flex items-center justify-center">
                0
              </span>
            </Button>
            <Button variant="ghost" size="icon" className="lg:hidden">
              <Menu className="h-5 w-5" />
            </Button>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;
