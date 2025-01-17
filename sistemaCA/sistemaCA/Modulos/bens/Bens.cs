﻿using System;
using System.Linq;
using System.Windows.Forms;

namespace sistemaCA.views.bens
{
    class Bens : ClasseBase
    {
        public tblben Ben { get; set; }
        //propriedade do bens

        public int ID_Bens { get; set; }
        public string Descricao { get; set; }
        public string TipoBens { get; set; }
        public string Cod_Controle { get; set; }
        public DateTime Data_Aquisicao { get; set; }
        public float Preco_Aquisicao { get; set; }
        public int Horimetro_incial { get; set; }
        public int Hodometro_incial { get; set; }
        public string Placa { get; set; }

        public Bens() : base(new DataClasses1DataContext())
        {
            Ben = new tblben();

        }

        public void VisualizarBens(DataGridView dgw)
        {
            try
            {

                var pesqui = from Ben in Banco.tblbens select Ben;

                dgw.DataSource = pesqui;

            }
            catch (Exception erro)
            {
                MessageBox.Show(erro.Message);
            }
        }

        public void CadastrarBens()
        {

            try
            {


                this.Ben.descricao = this.Descricao;
                this.Ben.codigoControle = this.Cod_Controle;
                this.Ben.data_aquisicao = this.Data_Aquisicao;
                this.Ben.hodometro_inicial = this.Hodometro_incial;
                this.Ben.horimetro_inicial = this.Horimetro_incial;
                this.Ben.preco_aquisicao = this.Preco_Aquisicao;
                this.Ben.placa = this.Placa;
                this.Ben.tipoben = this.TipoBens;

                Banco.tblbens.InsertOnSubmit(Ben);
                Banco.SubmitChanges();
                MessageBox.Show("Cadastrado com Sucesso!");
            }
            catch (Exception erro)
            {
                MessageBox.Show(erro.Message);
            }
        }


        // visualizar unico bens
        public tblben CaregarBen(int id_ben)
        {


            var result = from ben in Banco.tblbens
                         where ben.id_ben == id_ben
                         select ben;

            Ben = result.Single();

            this.ID_Bens = Ben.id_ben;
            this.Descricao = Ben.descricao;
            this.Cod_Controle = Ben.codigoControle;
            this.Data_Aquisicao = Convert.ToDateTime(Ben.data_aquisicao);
            this.Hodometro_incial = Convert.ToInt32(Ben.hodometro_inicial);
            this.Horimetro_incial = Convert.ToInt32(Ben.horimetro_inicial);
            this.Preco_Aquisicao = float.Parse(Ben.preco_aquisicao.ToString());
            this.TipoBens = Ben.tipoben;
            this.Placa = Ben.placa;

            return Ben;


        }


        public void AlterarBen(int id_ben)
        {
            try
            {
                var Pesqui = from ben in Banco.tblbens where ben.id_ben == id_ben select ben;

                Ben = Pesqui.Single();

                this.Ben.descricao = this.Descricao;
                this.Ben.codigoControle = this.Cod_Controle;
                this.Ben.data_aquisicao = this.Data_Aquisicao;
                this.Ben.hodometro_inicial = this.Hodometro_incial;
                this.Ben.horimetro_inicial = this.Horimetro_incial;
                this.Ben.preco_aquisicao = float.Parse(this.Preco_Aquisicao.ToString());
                this.Ben.placa = this.Placa;
                this.Ben.tipoben = this.TipoBens;


                Banco.SubmitChanges();
                MessageBox.Show("Registro Alterado com Sucesso.");
            }
            catch (Exception erro)
            {
                MessageBox.Show(erro.Message);

            }
        }


        public void DeletarBen(int idben)
        {
            try
            {
                var result = from ben in Banco.tblbens
                             where
                                 ben.id_ben == idben
                             select ben;

                Ben = result.Single();

                Banco.tblbens.DeleteOnSubmit(Ben);
                Banco.SubmitChanges();

                MessageBox.Show("Registro Excluido com Sucesso!");

            }
            catch (Exception erro)
            {

                MessageBox.Show(erro.Message);
            }
        }



    }
}
