import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter } from "@/components/ui/card";
import { ShoppingCart, Heart } from "lucide-react";
import { Badge } from "@/components/ui/badge";

interface ProductCardProps {
  id: string;
  name: string;
  description?: string;
  price: number;
  discount?: number;
  image_url?: string;
  category?: string;
  is_featured?: boolean;
}

const ProductCard = ({
  name,
  description,
  price,
  discount = 0,
  image_url,
  is_featured,
}: ProductCardProps) => {
  const finalPrice = price - (price * discount) / 100;
  const installment = finalPrice / 6;

  return (
    <Card className="group overflow-hidden border border-border hover:shadow-lg transition-all duration-300 hover:-translate-y-1">
      <div className="relative aspect-[4/3] overflow-hidden bg-muted">
        {discount > 0 && (
          <Badge className="absolute top-3 left-3 z-10 bg-accent text-accent-foreground font-bold px-3 py-1">
            {discount}% OFF
          </Badge>
        )}
        
        {is_featured && (
          <Badge className="absolute top-3 right-3 z-10 bg-primary text-primary-foreground font-semibold px-3 py-1">
            Destaque
          </Badge>
        )}
        
        <button className="absolute top-3 right-3 z-10 bg-background/80 backdrop-blur-sm p-2 rounded-full hover:bg-background transition-colors">
          <Heart className="h-4 w-4 text-foreground hover:fill-accent hover:text-accent" />
        </button>

        <img
          src={image_url || "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=800"}
          alt={name}
          className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500"
        />
      </div>

      <CardContent className="p-4 space-y-2">
        <h3 className="font-semibold text-foreground text-lg line-clamp-2 group-hover:text-accent transition-colors">
          {name}
        </h3>
        
        {description && (
          <p className="text-sm text-muted-foreground line-clamp-2">
            {description}
          </p>
        )}

        <div className="space-y-1">
          {discount > 0 && (
            <p className="text-sm text-muted-foreground line-through">
              R$ {price.toFixed(2).replace(".", ",")}
            </p>
          )}
          
          <div className="flex items-baseline gap-2">
            <span className="text-2xl font-bold text-foreground">
              R$ {finalPrice.toFixed(2).replace(".", ",")}
            </span>
          </div>
          
          <p className="text-sm text-muted-foreground">
            ou até 6x de R$ {installment.toFixed(2).replace(".", ",")} sem juros
          </p>
        </div>
      </CardContent>

      <CardFooter className="p-4 pt-0">
        <Button className="w-full bg-primary hover:bg-primary/90 text-primary-foreground font-semibold group/btn">
          <ShoppingCart className="mr-2 h-4 w-4 group-hover/btn:scale-110 transition-transform" />
          Comprar
        </Button>
      </CardFooter>
    </Card>
  );
};

export default ProductCard;
