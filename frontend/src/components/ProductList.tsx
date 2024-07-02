'use client';
import { buyProduct } from "@/lib/token";
import { toast } from "react-toastify";

type Product = {
  id: number;
  name: string;
  description: string;
  price: number;
  imageUrl: string;
};

const products: Product[] = [
  {
    id: 1,
    name: "Tênis de Corrida",
    description: "Tênis de corrida confortável e resistente.",
    price: 12,
    imageUrl: "/products/tenis.jpg",
  },
  {
    id: 2,
    name: "Kit de Panelas",
    description: "Conjunto de panelas antiaderentes para sua cozinha.",
    price: 18,
    imageUrl: "/products/panela.jpg",
  },
  {
    id: 3,
    name: "Batedeira",
    description: "Batedeira de alta performance para suas receitas.",
    price: 15,
    imageUrl: "/products/batedeira.jpg",
  },
  {
    id: 7,
    name: "Smartphone",
    description: "Smartphone com a última tecnologia e design inovador.",
    price: 10,
    imageUrl: "/products/smartphone.jpg",
  },
  {
    id: 8,
    name: "Tablet",
    description: "Tablet para trabalho e entretenimento.",
    price: 60,
    imageUrl: "/products/tablet.jpg",
  },
  {
    id: 9,
    name: "Smartwatch",
    description: "Smartwatch com monitoramento de atividades e saúde.",
    price: 30,
    imageUrl: "/products/relogio.jpg",
  },
  {
    id: 10,
    name: "Fone de Ouvido Bluetooth",
    description: "Fone de ouvido sem fio com alta qualidade de som.",
    price: 15,
    imageUrl: "/products/fone.jpg",
  },
  {
    id: 13,
    name: "Notebook",
    description: "Notebook de alta performance para trabalho e jogos.",
    price: 15,
    imageUrl: "/products/notebook.jpg",
  },
  {
    id: 14,
    name: "Câmera Fotográfica",
    description: "Câmera fotográfica profissional com alta resolução.",
    price: 8,
    imageUrl: "/products/camera.jpg",
  }
];

const ProductList = () => {
  const handleBuy = async (price: number) => {
    const accounts = await window.ethereum.request({
      method: 'eth_requestAccounts'
    });
    const address = accounts[0];
    try {
      const result = await buyProduct(address, price);
      if(result.isSuccess) {
        toast.success(`Sucesso sua transação foi confirmada ${result.txHash}`)
      } else {
        toast.error(`Ocorreu um erro: ${result.error}`)
      }
    } catch(e) { 
      toast.error(`Erro no envio da transação: ${e}`)
    }
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      {products.map((product) => (
        <div key={product.id} className="border p-4 rounded-lg shadow">
          <div className="min-h-72">
            <img src={product.imageUrl} alt={product.name} className="w-full h-48 object-cover rounded-t-lg" />
            <h2 className="text-xl font-bold mt-4">{product.name}</h2>
            <p className="text-gray-600">{product.description}</p>
          </div>
          <div className="flex justify-between items-center p-4">
            <p className="text-green-500 font-bold">$ {product.price} BTK</p>
            <button
              onClick={() => handleBuy(product.price)}
              className="bg-[#2BFDBE] text-[#01080E] py-2 px-4 rounded mt-4"
            >
              Comprar
            </button>
          </div>
        </div>
      ))}
    </div>
  );
};

export default ProductList;
