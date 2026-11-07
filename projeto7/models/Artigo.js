const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Artigo = sequelize.define(
  'Artigo',
  {
    idArtigo: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    titulo: {
      type: DataTypes.STRING(128),
      allowNull: false,
    },
    slug: {
      type: DataTypes.STRING(128),
      allowNull: false,
    },
    resumo: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    conteudo: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    imagem: {
      type: DataTypes.STRING(256),
      allowNull: true,
    },
  },
  {
    tableName: 'artigos',
    timestamps: false,
  },
);
module.exports = Artigo;
