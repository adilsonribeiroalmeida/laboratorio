window
  .fetch('http://127.0.0.1:5500/projeto3/api/produtos.json')
  .then((resposta) => resposta.json())
  .then((produtos) => {
    let html = '';
    produtos.forEach((produto) => {
      html += `
      <div class="border p-2">
            <div class="text-center">
              <img
                src="./img/${produto.imagem}"
                alt="Borrifador"
                class="img-fluid"
              />
            </div>
            <h3 class="mt-1">${produto.nome}</h3>
            <p class="mt-1">
              ${produto.descricao}
            </p>
            <div class="mt-1 d-flex justify-content-between align-items-center">
              <span>
                R$
                <span class="text-success">${produto.preco.toFixed(2).replace('.', ',')}</span>
              </span>
              <button
                class="btn btn-success"
                onclick="
                  adicionarProdutoAoCarrinho(
                  ${produto.id},
                    '${produto.nome}',
                    ${produto.preco},
                    '${produto.imagem}'
                  )
                "
              >
                <i class="fa-solid fa-plus"></i>
              </button>
            </div>
          </div>
      `;
      document.getElementById('lista-de-produtos').innerHTML = html;
    });
  });
