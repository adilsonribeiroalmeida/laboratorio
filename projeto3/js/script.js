document.getElementById('hamburguer').addEventListener('click', function () {
  // window.alert('clicou no hamburguer');
  document.getElementById('menu').classList.toggle('d-none');
});

function adicionarProdutoAoCarrinho(id, nome, preco, imagem) {
  let carrinho = JSON.parse(localStorage.getItem('carrinho')) || [];
  let produtoExistente = carrinho.find((produto) => produto.id == id);
  if (produtoExistente) {
    produtoExistente.quantidade++;
  } else {
    let produto = {
      id,
      nome,
      preco,
      imagem,
      quantidade: 1,
    };
    carrinho.push(produto);
  }
  localStorage.setItem('carrinho', JSON.stringify(carrinho));
  atualizarContadorDeProdutosNoCarrinho();
}
function contadorDeProdutosNoCarrinho() {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let contador = 0;
  carrinho.forEach((produto) => (contador += produto.quantidade));
  return contador;
}
function atualizarContadorDeProdutosNoCarrinho() {
  document.getElementById('carrinho-quantidade').textContent =
    contadorDeProdutosNoCarrinho();
}
atualizarContadorDeProdutosNoCarrinho();