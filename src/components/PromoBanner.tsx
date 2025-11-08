import { Button } from "@/components/ui/button";
import { ArrowRight } from "lucide-react";
import heroBanner from "@/assets/hero-banner.jpg";

const PromoBanner = () => {
  return (
    <section className="relative w-full h-[500px] md:h-[600px] overflow-hidden rounded-2xl mx-auto my-8 max-w-[1400px] px-4">
      <div className="absolute inset-0">
        <img
          src={heroBanner}
          alt="Promoção"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-primary/90 via-primary/60 to-transparent" />
      </div>
      
      <div className="relative h-full flex items-center">
        <div className="container mx-auto px-4">
          <div className="max-w-2xl space-y-6 text-primary-foreground">
            <div className="inline-block bg-accent text-accent-foreground px-4 py-2 rounded-full text-sm font-semibold animate-pulse">
              OFERTA ESPECIAL
            </div>
            
            <h2 className="text-4xl md:text-6xl font-bold leading-tight">
              Até 30% OFF no Colchão dos seus Sonhos
            </h2>
            
            <p className="text-lg md:text-xl opacity-90">
              Condições especiais por tempo limitado! Frete grátis a partir de R$ 300
            </p>
            
            <div className="flex flex-wrap gap-4 pt-4">
              <Button size="lg" className="bg-accent hover:bg-accent/90 text-accent-foreground font-semibold group">
                Ver Ofertas
                <ArrowRight className="ml-2 h-5 w-5 group-hover:translate-x-1 transition-transform" />
              </Button>
              <Button size="lg" variant="outline" className="bg-background/10 backdrop-blur-sm border-primary-foreground text-primary-foreground hover:bg-background/20">
                Saber Mais
              </Button>
            </div>

            {/* Countdown Timer */}
            <div className="flex gap-4 pt-6">
              {[
                { value: "00", label: "DIAS" },
                { value: "00", label: "HORAS" },
                { value: "00", label: "MIN" },
                { value: "00", label: "SEG" }
              ].map((item, index) => (
                <div key={index} className="text-center bg-background/20 backdrop-blur-sm rounded-lg px-4 py-2">
                  <div className="text-2xl md:text-3xl font-bold">{item.value}</div>
                  <div className="text-xs opacity-80">{item.label}</div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

export default PromoBanner;
