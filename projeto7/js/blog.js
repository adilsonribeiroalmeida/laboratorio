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