const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Servico = sequelize.define(
  'Servico',
  {
    idServico: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    nome: {
      type: DataTypes.STRING(128),
      allowNull: false,
    },
    slug: {
      type: DataTypes.STRING(128),
      allowNull: false,
    },
    descricao: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    tempoExecucao: {
      type: DataTypes.TIME,
      allowNull: false,
    },
    validade: {
      type: DataTypes.STRING(64),
      allowNull: false,
    },
    preco: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    imagem: {
      type: DataTypes.STRING(256),
      allowNull: true,
    },
  },
  {
    tableName: 'servicos',
    timestamps: false,
  },
);
module.exports = Servico;
