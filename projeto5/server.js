const express = require('express');
const path = require('path');
const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use('/css', express.static(path.join(__dirname, 'css')));
app.use('/js', express.static(path.join(__dirname, 'js')));
app.use('/img', express.static(path.join(__dirname, 'img')));
app.use('/api', express.static(path.join(__dirname, 'api')));

app.get('/', (req, res) => {
  // res.send('Home');
  res.render('index');
});

app.get('/index', (req, res) => {
  // res.send('Home');
  res.render('index');
});


app.get('/sobre', (req, res) => {
  //res.send('Sobre');
  res.render('sobre');
});

app.get('/contato', (req, res) => {
  //res.send('Você acessou a página contato');
  res.render('contato');
});

app.get('/servicos', (req, res) => {
  //res.send('Você acessou a página serviços');
  res.render('servicos');
});

app.get('/produtos', (req, res) => {
  //res.send('Você acessou a página produtos');
  res.render('produtos');
});

app.get('/blog', (req, res) => {
  //res.send('Você acessou a página blog');
  res.render('blog');
});

app.get('/carrinho', (req, res) => {
  //res.send('Você acessou a página carrinho');
  res.render('carrinho');
});

app.get('/blog-titulo-1', (req, res) => {
  //res.send('Você acessou o primeiro artigo do blog');
  res.render('blog-titulo-1');
});

app.get('/blog-titulo-2', (req, res) => {
  //res.send('Você acessou o segundo artigo do blog');
  res.render('blog-titulo-2');
});

app.get('/blog-titulo-3', (req, res) => {
  //res.send('Você acessou o terceiro artigo do blog');
  res.render('blog-titulo-3');
});

app.get('/checkout', (req, res) => {
  //res.send('Você acessou a página checkout');
  res.render('checkout');
});

app.get('/obrigado', (req, res) => {
  //res.send('Você acessou a pasta obrigado');
  res.render('obrigado');
});

app.get('/plano-business', (req, res) => {
  //res.send('Você acessou o plano business');
  res.render('plano-business');
});

app.get('/plano-premium', (req, res) => {
  //res.send('Você acessou o plano premium');
  res.render('plano-premium');
});

app.get('/plano-standard', (req, res) => {
  //res.send('Você acessou o plano standard');
  res.render('plano-standard');
});

app.get('/servico-adubacao-e-fertilizacao', (req, res) => {
  //res.send('Você acessou a pasta de servico-adubacao-e-fertilizacao');
  res.render('servico-adubacao-e-fertilizacao');
});

app.get('/servico-controle-de-pragas', (req, res) => {
  //res.send('Você acessou a pasta de servico-controle-de-pragas');
  res.render('servico-controle-de-pragas');
});

app.get('/servico-corte-e-manutencao', (req, res) => {
  //res.send('Você acessou a pasta de servico-corte-e-manutencao');
  res.render('servico-corte-e-manutencao');
});

app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});
