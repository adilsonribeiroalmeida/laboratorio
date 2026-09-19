import express from 'express';

const app = express();

app.get('/', (req, res) => {
  res.send('Home');
});

app.get('/sobre', (req, res) => {
  res.send('Sobre');
});

app.get('/contato',(req, res)=>{
    res.send('Você acessou a página contato');
});

app.get('/servicos',(req, res)=>{
    res.send('Você acessou a página serviços')
});

app.get('/produtos',(req, res)=>{
    res.send('Você acessou a página produtos');
});

app.get('/blog',(req, res)=>{
    res.send('Você acessou a página blog');
});

app.get('/carrinho',(req, res)=>{
    res.send('Você acessou a página carrinho');
});

app.get('/blog-titulo-1',(req, res)=>{
    res.send('Você acessou o primeiro artigo do blog');
});

app.get('/blog-titulo-2',(req, res)=>{
    res.send('Você acessou o segundo artigo do blog');
});

app.get('/blog-titulo-3',(req, res)=>{
    res.send('Você acessou o terceiro artigo do blog');
});

app.get('/checkout',(req, res)=>{
    res.send('Você acessou a página checkout');
});

app.get('/obrigado',(req, res)=>{
    res.send('Você acessou a pasta obrigado');
});

app.get('/plano-business',(req, res)=>{
    res.send('Você acessou o plano business');
});

app.get('/plano-premium',(req, res)=>{
    res.send('Você acessou o plano premium');
});

app.get('/plano-standard',(req, res)=>{
    res.send('Você acessou o plano standard');
});

app.get('/servico-adubacao-e-fertilizacao',(req, res)=>{
    res.send('Você acessou a pasta de servico-adubacao-e-fertilizacao');
});

app.get('/servico-controle-de-pragas',(req, res)=>{
    res.send('Você acessou a pasta de servico-controle-de-pragas');
});

app.get('/servico-corte-e-manutencao',(req, res)=>{
    res.send('Você acessou a pasta de servico-corte-e-manutencao');
});

app.listen(3000, () => {
  console.log('Servidor rodando em http://localhost:3000');
});
