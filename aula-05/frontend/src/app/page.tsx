import Head from 'next/head';
import Header from '../components/Header';
import ProductList from '../components/ProductList';

const Home = () => {
  return (
    <div>
      <Head>
        <title>Programa de fideliade</title>
        <meta name="description" content="Marketplace de aulas mockado" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <Header />

      <main className="container mx-auto px-4">
        <h1 className="text-4xl font-bold text-center my-8">Produtos disponíveis</h1>
        <ProductList />
      </main>

    </div>
  );
};

export default Home;
