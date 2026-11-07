const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Produto = sequelize.define(
  'Produto',
  {
    idProduto: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    idCategoria: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    nome: {
      type: DataTypes.STRING(128),
      allowNull: false,
    },
    preco: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false,
    },
    quantidade: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
  },
  {
    tableName: 'produtos',
    timestamps: false,
  },
);
module.exports = Produto;
