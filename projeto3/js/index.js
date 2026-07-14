window
  .fetch('http://127.0.0.1:5500/projeto3/api/produtos.json')
  .then((resposta) => resposta.json())
  .then((produtos) => {
    let html = '';
    produtos.forEach((produto)=>{
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
                <span class="text-success">${produto.preco.toFixed(2).replace('.',',')}</span>
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
  // SERVIÇOS
fetch('./api/servicos.json')
  .then((resposta) => resposta.json())
  .then((servicos) => {
    let html = '';

    servicos.forEach((servico) => {
      html += `
        <div>
          <div
            class="capa shadow"
            style="background-image: url('./img/${servico.imagem}');"
          ></div>

          <h3 class="fs-2 fw-normal text-warning mb-2 mt-3">
            ${servico.nome}
          </h3>

          <p class="mb-1">
            ${servico.descricao}
          </p>

          <a href="${servico.url}" class="text-decoration-none">
            <span> + </span>
            <span class="text-dark">Saiba mais</span>
          </a>
        </div>
      `;
    });

    document.getElementById('lista-de-servicos').innerHTML = html;
  });
  fetch('./api/posts.json')
  .then((resposta) => resposta.json())
  .then((posts) => {
    let html = '';

    posts.forEach((post) => {
      html += `
      <div>
            <div
              class="ratio-4x3 capa"
              style="background-image: url('./img/${post.imagem}')"
            ></div>
            <h3 class="mt-3 fs-2 fw-normal mb-1">${post.nome}</h3>
            <p class="mb-1">
             ${post.descricao}
            </p>
            <a
              href="${post.url}"
              class="text-decoration-none text-warning"
              >Leia mais</a
            >
          </div> 
      `;
    });

    document.getElementById('lista-de-posts').innerHTML = html;
  });
   fetch('./api/depoimentos.json')
  .then((resposta) => resposta.json())
  .then((depoimentos) => {
    let html = '';

    depoimentos.forEach((depoimento) => {
      html += `
        <iframe
          class="d-block w-100"
            src="https://www.youtube.com/embed/${depoimento.codigoYoutube}?si=heKYObHxMWmToNN5"
            title="YouTube video player"
            frameborder="0"
            allow="
              accelerometer;
              autoplay;
              clipboard-write;
              encrypted-media;
              gyroscope;
              picture-in-picture;
              web-share;
            "
            referrerpolicy="strict-origin-when-cross-origin"
            allowfullscreen
          ></iframe>

      `;
    });

    document.getElementById('lista-de-depoimentos').innerHTML = html;
  });