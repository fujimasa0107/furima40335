const price = () => {
  const priceInput = document.getElementById('item-price');
  const feeOutput = document.getElementById('add-tax-price');
  const profitOutput = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const price = parseInt(priceInput.value);
    if (price >= 300 && price < 10000000) {
      const fee = Math.floor(price * 0.1); // 手数料は価格の10%
      const profit = Math.floor(price - fee);

      feeOutput.textContent = fee; // 販売手数料を表示
      profitOutput.textContent = profit; // 販売利益を表示
    } else {
      feeOutput.textContent = '--';
      profitOutput.textContent = '--';
    }
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);