﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using sistemaCA.views.bens;
using sistemaCA.views.produtos;
using sistemaCA.views.safra;
using sistemaCA.views.talhao;
using sistemaCA.views.fornecedor;
namespace sistemaCA.views
{
    public partial class telaprincipal : Form
    {
        public telaprincipal()
        {
            InitializeComponent();
        }

        private void usuárioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //formUsuario formuser = new formUsuario();

            //formuser.WindowState = System.Windows.Forms.FormWindowState.Maximized;

            //formuser.MdiParent = this;
            //formuser.Show();

        }

        private void funcionarioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            formFuncionario formfunci = new formFuncionario();
            formfunci.ShowDialog();
        }

        private void telaprincipal_Load(object sender, EventArgs e)
        {
            

        }

        private void administradorToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void cadastroUsuárioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            formUsuario formuser = new formUsuario();

            formuser.Show();

        }

        private void produtoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            formProduto fpro = new formProduto();

            fpro.ShowDialog();

            
            
        }

        private void safraToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormSafra formsafra = new FormSafra();
            formsafra.Show();

        }

        private void talhãoToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormTalhao formtalhao = new FormTalhao();
            formtalhao.Show();
        }

        private void bensToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormFornecedores fornecedor =new FormFornecedores();
            fornecedor.Show();
        }

        private void fornecedoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Formbens Formben =new Formbens();
            Formben.Show();
        }
    }
}
