document.getElementById('hamburguer').addEventListener('click', function () {
  // window.alert('clicou no hamburguer');
  document.getElementById('menu').classList.toggle('d-none');
});

function soma(numero1, numero2) {
  return numero1 + numero2;
}
function subtracao(numero1, numero2) {
  return numero1 - numero2;
}
function multiplicacao(numero1, numero2) {
  return numero1 * numero2;
}
console.log(multiplicacao(45, 88));

function divisao(numero1, numero2) {
  return numero1 / numero2;
}
console.log(divisao(22, 44));

function media(numero1, numero2, numero3, numero4) {
  return (numero1 + numero2 + numero3 + numero4) / 4;
}
console.log(media(10, 10, 10, 10));

function regrade3(numero1, numero2, numero3){
return (numero3*numero2)/numero1;
}
console.log(regrade3(10,100,20));

