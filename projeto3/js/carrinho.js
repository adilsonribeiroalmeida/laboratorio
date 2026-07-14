document.addEventListener('DOMContentLoaded', () => {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  if (carrinho.length > 0) {
    let html = '';
    carrinho.forEach((produto) => {
      html += `
<tr id="linha-produto-${produto.id}">
              <td class="d-flex align-items-center column-gap-2">
                <img src="./img/${produto.imagem}" alt="" style="width:75px" />
                <span>${produto.nome}</span>
              </td>
              <td class="text-center">
                <button class="btn" onclick="diminuiQuantidadeDoProdutoNoCarrinho(${produto.id})">
                  <i class="fa-solid fa-minus"></i>
                </button>
                <button class="btn" id="quantidade-produto-${produto.id}">${produto.quantidade}</button>
                <button class="btn" onclick="aumentaQuantidadeDoProdutoNoCarrinho(${produto.id})">
                  <i class="fa-solid fa-plus"></i>
                </button>
              </td>
              <td class="text-center">R$ ${produto.preco.toFixed(2).replace('.', ',')}</td>
              <td class="text-center">R$ 
              <span id="total-produto-${produto.id}">
              ${(produto.quantidade * produto.preco).toFixed(2).replace('.', ',')}
              </span>
              </td>
              <td class="text-center">
                <button class="btn btn-warning" onclick="removerProdutoDoCarrinho(${produto.id})">
                  <i class="fa-solid fa-xmark"></i>
                </button>
              </td>
            </tr>
`;
    });
    document.getElementById('corpo-tabela').innerHTML = html;
  } else {
    document.getElementById('corpo-tabela').innerHTML =
      '<td colspan="5" class="text-center">Carrinho vazio.</td>';
  }
});
document.addEventListener('DOMContentLoaded', () => {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  if (carrinho.length > 0) {
    let html = '';
    carrinho.forEach((produto) => {
      html += `
      <div id="linha-produto-mb-${produto.id}">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <img src="./img/${produto.imagem}" alt="${
      produto.nome
    }" style="width: 75px;">
                            <span>
                                ${produto.nome}
                                <br>
                                R$ <span id="total-produto-mb-${produto.id}">
                                    ${(
                                      produto.preco * produto.quantidade
                                    ).toLocaleString("pt-BR", {
                                      minimumFractionDigits: 2,
                                      maximumFractionDigits: 2,
                                    })}
                                </span>
                            </span>
                        </div>
                        <div class="d-flex">
                            <div class="d-flex botoes">
                                <button class="btn" onclick="diminuiQuantidadeDoProdutoNoCarrinho(${
                                  produto.id
                                })">
                                    <i class="fa-solid fa-minus"></i>
                                </button>
                                <button class="btn" id="quantidade-produto-mb-${
                                  produto.id
                                }">
                                    ${produto.quantidade}
                                </button>
                                <button class="btn" onclick="aumentaQuantidadeDoProdutoNoCarrinho(${
                                  produto.id
                                })">
                                    <i class="fa-solid fa-plus"></i>
                                </button>
                            </div>
                            <div class="text-center ps-2">
                                <button class="btn btn-warning" onclick="removerProdutoDoCarrinho(${
                                  produto.id
                                })">
                                    <i class="fa-solid fa-xmark"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
`;
    });
    document.getElementById('carrinho-mobile').innerHTML = html;
  } else {
    document.getElementById('carrinho-mobile').innerHTML =
      'Carrinho vazio.';
  }
});
function removerProdutoDoCarrinho(id) {
  let confirmacao = window.confirm(
    'Deseja realmente excluir o produto do carrinho?',
  );
  //console.log(confirmacao);
  if (confirmacao) {
    let carrinho = JSON.parse(localStorage.getItem('carrinho'));
    //console.log(carrinho);
    carrinho = carrinho.filter((produto) => produto.id !== id);
    //console.log(carrinho);
    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    document.getElementById(`linha-produto-${id}`).remove();
    document.getElementById(`linha-produto-mb-${id}`).remove();
    if (carrinho.length === 0) {
      document.getElementById('corpo-tabela').innerHTML =
        '<td colspan="5" class="text-center">Carrinho vazio.</td>';
    }
  }
}
function aumentaQuantidadeDoProdutoNoCarrinho(id) {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let produto = carrinho.find((produto) => produto.id === id);
  if (produto) {
    produto.quantidade++;
    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    atualizaQuantidadeDoProdutoNaLinha(id);
    atualizaTotalDoProdutoNaLinha(id);
    atualizarContadorDeProdutosNoCarrinho();
  }
}
function diminuiQuantidadeDoProdutoNoCarrinho(id) {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let produto = carrinho.find((produto) => produto.id === id);
  if (produto && produto.quantidade > 1) {
    produto.quantidade--;
    localStorage.setItem('carrinho', JSON.stringify(carrinho));
    atualizaQuantidadeDoProdutoNaLinha(id);
    atualizaTotalDoProdutoNaLinha(id);
    atualizarContadorDeProdutosNoCarrinho();
  }
}
function quantidadeDoProdutoNoCarrinho(id) {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let produto = carrinho.find((produto) => produto.id === id);
  return produto.quantidade;
}
function atualizaQuantidadeDoProdutoNaLinha(id) {
  document.getElementById(`quantidade-produto-${id}`).textContent =
    quantidadeDoProdutoNoCarrinho(id);
    document.getElementById(`quantidade-produto-mb-${id}`).textContent= quantidadeDoProdutoNoCarrinho(id);
}
function atualizaTotalDoProdutoNaLinha(id){
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let produto = carrinho.find((produto) => produto.id === id);
  let precoTotal = (produto.preco*produto.quantidade).toFixed(2).replace('.',',');
  document.getElementById(`total-produto-${id}`).textContent=precoTotal;
  document.getElementById(`total-produto-mb-${id}`).textContent=precoTotal;
}