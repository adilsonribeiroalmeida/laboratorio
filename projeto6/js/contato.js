document.addEventListener('DOMContentLoaded', () => {
  document
    .getElementById('formulario-contato')
    .addEventListener('submit', function (evento) {
      evento.preventDefault();
      let email = document.getElementById('email').value;
      let nome = document.getElementById('nome').value;
      let telefone = document.getElementById('telefone').value;
      let mensagem = document.getElementById('mensagem').value;
      let mensagemCompleta = `Novo contato!\n\n`;
      mensagemCompleta += `Email: ${email}\n`;
      mensagemCompleta += `Nome: ${nome}\n`;
      mensagemCompleta += `Telefone: ${telefone}\n`;
      mensagemCompleta += `Mensagem: ${mensagem}`;
      let mensagemCompletaFormatada = encodeURIComponent(mensagemCompleta);
      let numeroWhatsapp = '+5517997428837';
      window.open(
        `https://wa.me/${numeroWhatsapp}?text=${mensagemCompletaFormatada}`,
        '_blank',
      );
    });
  });
