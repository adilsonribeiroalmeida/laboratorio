const express = require('express');
const path = require('path');
const sequelize = require('./config/database');
const Servico = require('./models/Servico');
const Produto = require('./models/Produto');
const app = express();

async function testarConecao() {
  try {
    await sequelize.authenticate();
    console.log('conectado ao mysql sequelize');
  } catch (erro) {
    console.log('erro ao conectar com sequelize');
    console.log(erro);
  }
}

testarConecao();

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

app.get('/servicos', async (req, res) => {
  const servicos = await Servico.findAll({
    raw: true,
  });
  res.render('servicos', { servicos });
});

app.get('/servicos/:slug', (req, res) => {
  const { slug } = req.params;
  const sql = `select * from servicos where slug = ?`;
  conexao.query(sql, [slug], (erro, registros) => {
    const servico = registros[0];
    res.render('servico', { servico });
  });
});

app.get('/produtos', async (req, res) => {
  const produtos = await Produto.findAll({
    raw: true,
  });
  res.render('produtos', { produtos });
});

app.get('/blog', async (req, res) => {
  const artigos = await Artigo.findAll({
    raw: true,
  });
  res.render('artigos', { artigos });
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
