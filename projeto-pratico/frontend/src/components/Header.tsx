import MetaMaskConnect from "./MetamaskConnect";

const Header = () => {
  return (
    <header className="bg-[#2BFDBE] p-4">
      <div className="container mx-auto flex justify-between items-center">
        <h1 className="text-xl font-bold text-[#01080E]">BANCO XPTO SHOP</h1>
        <MetaMaskConnect />
      </div>
    </header>
  );
};

export default Header;
