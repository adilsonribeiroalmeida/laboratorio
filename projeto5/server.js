const express = require('express');
const path = require('path');
const app = express();

app.use('/css', express.static(path.join(__dirname, 'css')));
app.use('/js', express.static(path.join(__dirname, 'js')));
app.use('/img', express.static(path.join(__dirname, 'img')));
app.use('/api', express.static(path.join(__dirname, 'api')));

app.get('/', (req, res) => {
 // res.send('Home');
 res.sendFile(path.join(__dirname,'pages','index.html'));
});

app.get('/sobre', (req, res) => {
  //res.send('Sobre');
  res.sendFile(path.join(__dirname,'pages','sobre.html'));
});

app.get('/contato', (req, res) => {
  //res.send('Você acessou a página contato');
  res.sendFile(path.join(__dirname,'pages','contato.html'));
});

app.get('/servicos', (req, res) => {
  //res.send('Você acessou a página serviços');
  res.sendFile(path.join(__dirname,'pages','servicos.html'));
});

app.get('/produtos', (req, res) => {
  //res.send('Você acessou a página produtos');
  res.sendFile(path.join(__dirname,'pages','produtos.html'));
});

app.get('/blog', (req, res) => {
  //res.send('Você acessou a página blog');
  res.sendFile(path.join(__dirname,'pages','blog.html'));
});

app.get('/carrinho', (req, res) => {
  //res.send('Você acessou a página carrinho');
  res.sendFile(path.join(__dirname,'pages','carrinho.html'));
});

app.get('/blog-titulo-1', (req, res) => {
  //res.send('Você acessou o primeiro artigo do blog');
res.sendFile(path.join(__dirname,'pages','blog-titulo-1.html'));
});

app.get('/blog-titulo-2', (req, res) => {
  //res.send('Você acessou o segundo artigo do blog');
  res.sendFile(path.join(__dirname,'pages','blog-titulo-2.html'));
});

app.get('/blog-titulo-3', (req, res) => {
  //res.send('Você acessou o terceiro artigo do blog');
  res.sendFile(path.join(__dirname,'pages','blog-titulo-3.html'));
});

app.get('/checkout', (req, res) => {
  //res.send('Você acessou a página checkout');
  res.sendFile(path.join(__dirname,'pages','checkout.html'));
});

app.get('/obrigado', (req, res) => {
  //res.send('Você acessou a pasta obrigado');
   res.sendFile(path.join(__dirname,'pages','obrigado.html'));
});

app.get('/plano-business', (req, res) => {
  //res.send('Você acessou o plano business');
  res.sendFile(path.join(__dirname,'pages','plano-business.html'));
});

app.get('/plano-premium', (req, res) => {
  //res.send('Você acessou o plano premium');
  res.sendFile(path.join(__dirname,'pages','plano-premium.html'));
});

app.get('/plano-standard', (req, res) => {
  //res.send('Você acessou o plano standard');
  res.sendFile(path.join(__dirname,'pages','plano-standard.html'));
});

app.get('/servico-adubacao-e-fertilizacao', (req, res) => {
  //res.send('Você acessou a pasta de servico-adubacao-e-fertilizacao');
  res.sendFile(path.join(__dirname,'pages','servico-adubacao-e-fertilizacao.html'));
});

app.get('/servico-controle-de-pragas', (req, res) => {
  //res.send('Você acessou a pasta de servico-controle-de-pragas');
  res.sendFile(path.join(__dirname,'pages','servico-controle-de-pragas.html'));
});

app.get('/servico-corte-e-manutencao', (req, res) => {
  //res.send('Você acessou a pasta de servico-corte-e-manutencao');
  res.sendFile(path.join(__dirname,'pages','servico-corte-e-manutencao.html'));
});

app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});
