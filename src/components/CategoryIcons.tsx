import { Armchair, Box, Package, CloudMoon, BedDouble, Sparkles, Home } from "lucide-react";

const categories = [
  { name: "Colchões", icon: BedDouble, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Bases", icon: Box, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Conjuntos", icon: Package, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Cabeceiras", icon: Armchair, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Roupas de Cama", icon: Sparkles, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Travesseiros", icon: CloudMoon, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Acessórios", icon: Sparkles, color: "bg-accent/10 hover:bg-accent/20" },
  { name: "Móveis", icon: Home, color: "bg-accent/10 hover:bg-accent/20" },
];

const CategoryIcons = () => {
  return (
    <section className="py-16 bg-secondary/30">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl md:text-4xl font-bold text-center mb-12 text-foreground">
          Encontre o que procura
        </h2>
        
        <div className="grid grid-cols-2 sm:grid-cols-4 lg:grid-cols-8 gap-6">
          {categories.map((category, index) => {
            const Icon = category.icon;
            return (
              <button
                key={index}
                className="flex flex-col items-center gap-3 group cursor-pointer"
              >
                <div className={`${category.color} w-20 h-20 md:w-24 md:h-24 rounded-full flex items-center justify-center transition-all duration-300 group-hover:scale-110 shadow-sm group-hover:shadow-md`}>
                  <Icon className="h-10 w-10 md:h-12 md:w-12 text-accent" />
                </div>
                <span className="text-xs md:text-sm font-medium text-foreground text-center group-hover:text-accent transition-colors">
                  {category.name}
                </span>
              </button>
            );
          })}
        </div>
      </div>
    </section>
  );
};

export default CategoryIcons;
