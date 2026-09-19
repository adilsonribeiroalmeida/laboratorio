document.addEventListener('DOMContentLoaded', () => {
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let total=0;
  let html = '';
  if (carrinho.length > 0) {
    carrinho.forEach((produto) => {
        total+=(produto.quantidade*produto.preco)
      html += `
        <tr>
        <td>
        ${produto.nome}
        </td>
        <td class="text-center">
        ${produto.quantidade}
        </td>
        <td class="text-center">
        R$
        ${(produto.quantidade * produto.preco).toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})}
        </td>
        </tr>
        `;
    });
    document.getElementById('itens').innerHTML=html;
    document.getElementById('total').textContent=total.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2});
  } else {
    html+='<tr><td colspan="3" class="text-center">Carrinho vazio.</td></tr>';
    document.getElementById('itens').innerHTML=html;
  }
});
document.getElementById('formulario').addEventListener('submit',function(evento){
  evento.preventDefault();
  //console.log('evento submit executado');
  let nome = document.getElementById('nome').value;
  let email = document.getElementById('email').value;
  let telefone = document.getElementById('telefone').value;
  let carrinho = JSON.parse(localStorage.getItem('carrinho'));
  let mensagem = `Novo pedido!\n\n`;
  mensagem += `Nome: ${nome}\n`;
  mensagem += `Email: ${email}\n`;
  mensagem += `Telefone: ${telefone}\n\n`;
  let total = 0;
  carrinho.forEach((produto)=>{
    let subtotal = produto.preco*produto.quantidade;
    total += subtotal;
    mensagem += `${produto.nome} - ${produto.quantidade} X R$ ${produto.preco.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})} = R$ ${subtotal.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})}\n`;
  });
  mensagem += `\nTotal: R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2,maximumFractionDigits:2})}`;
  let mensagemFormatada = encodeURIComponent(mensagem);
  let numeroWhatsapp = '+5517997428837';
  window.open(`https://wa.me/${numeroWhatsapp}?text=${mensagemFormatada}`,'_blank');
  localStorage.removeItem('carrinho');
  window.location.href = './obrigado.html';
  //console.log(mensagem);
});