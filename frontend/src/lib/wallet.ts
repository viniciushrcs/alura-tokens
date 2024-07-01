import { ethers } from "ethers";
import { toast } from "react-toastify";

const tokenAddress = '0x8650D02031aDdd9093DB938194CE9Bd80B5754DE';
const tokenABI = [
  "function balanceOf(address owner) view returns (uint256)"
];

export const connectWallet = async () => {
  if (window.ethereum) {
    try {
      const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = provider.getSigner();
      const account = accounts[0];

      const tokenContract = new ethers.Contract(tokenAddress, tokenABI, provider);
      const balance = await tokenContract.balanceOf(account);
      const balanceInTokens = ethers.formatUnits(balance, 18);

      return { account, balance: balanceInTokens, provider, signer };
    } catch (error) {
      console.error('Usuário negou acesso a carteira');
      toast.error('Por favor, conecte sua carteira para continuar')
    }
  } else {
    console.error('Carteira não encontrada');
    throw new Error('Carteira não encontrada');
  }
};

