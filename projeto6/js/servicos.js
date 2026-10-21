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