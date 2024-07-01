import { ethers } from "ethers";
const tokenAddress = '0xC94EE05b5686C18A5b76dcfF1965Ec6327227E19';

const tokenABI = [
    "function balanceOf(address owner) view returns (uint256)"
  ];

export const connectWallet = async () => {
   if(window.ethereum){ try {
    const accounts = await window.ethereum.request({
        method: 'eth_requestAccounts'
    });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const account = accounts[0];
    const token = new ethers.Contract(tokenAddress, tokenABI, provider)
    const balance =  await token.balanceOf(account);
    const balanceInTokens = ethers.formatUnits(balance, 18);
    console.log('Balance', balanceInTokens)
    return { balanceInTokens, balance, account, signer }
    } catch(error) {
        console.error("Erro ao conectar wallet", error)
    }}

}  