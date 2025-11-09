import Header from "@/components/Header";
import PromoBanner from "@/components/PromoBanner";
import CategoryIcons from "@/components/CategoryIcons";
import ProductList from "@/components/ProductList";
import Footer from "@/components/Footer";
import { CategoryFilterProvider } from "@/hooks/useCategoryFilter";
import { ProductSearchProvider } from "@/hooks/useProductSearchContext";

const Index = () => {
  return (
    <div className="min-h-screen bg-background">
      <CategoryFilterProvider>
        <ProductSearchProvider>
          <Header />
          <main>
            <PromoBanner />
            <CategoryIcons />
            <ProductList />
          </main>
        </ProductSearchProvider>
      </CategoryFilterProvider>
      <Footer />
    </div>
  );
};

export default Index;
