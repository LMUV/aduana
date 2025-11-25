using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using Aduana.Controllers;

namespace aduana
{
    public partial class AgregarMercancia : Page
    {
        string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
             
            {
                string idDeclaracion = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(idDeclaracion))
                {
                    CargarDatosDeclaracion(idDeclaracion);
                }
               
            }
        }



        private void CargarDatosDeclaracion(string id)
        {
            using (SqlConnection cnn = new SqlConnection(conexion))
            {
                cnn.Open();

                string query = @"
            SELECT *
            FROM Mercancia
            WHERE IdDeclaracion = @id";

                SqlCommand cmd = new SqlCommand(query, cnn);
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Cambia estos campos por los reales de tu tabla Mercancia
                    if (reader["Descripcion"] != DBNull.Value)
                        txtDescripcion.Text = reader["Descripcion"].ToString();

                    if (reader["Tipo"] != DBNull.Value)
                        txtTipo.Text = reader["Tipo"].ToString();

                    if (reader["ValorDeclarado"] != DBNull.Value)
                        txtValor.Text = reader["ValorDeclarado"].ToString();
                }

                reader.Close();
            }
        }


        protected void btnGuardarMercancia_Click(object sender, EventArgs e)
        {
            try
            {
                string idDeclaracion = Request.QueryString["id"];

                if (string.IsNullOrEmpty(idDeclaracion))
                {
                    lblMensaje.Text = "No se encontró la declaración asociada.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // VALIDACIONES
                if (string.IsNullOrWhiteSpace(txtDescripcion.Text))
                {
                    lblMensaje.Text = "Debe ingresar la descripción.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtTipo.Text))
                {
                    lblMensaje.Text = "Debe ingresar el tipo de mercancía.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                decimal valorDeclarado = 0;
                if (!decimal.TryParse(txtValor.Text, out valorDeclarado))
                {
                    lblMensaje.Text = "Debe ingresar un valor válido.";
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Resultado inspección (Normal / Sospechosa)
                string resultado = ddlResultado.SelectedValue;

                using (SqlConnection con = new SqlConnection(conexion))
                {
                    string query = @"
                INSERT INTO Mercancia (IdDeclaracion, Descripcion, Tipo, ValorDeclarado, ResultadoInspeccion)
                VALUES (@IdDeclaracion, @Descripcion, @Tipo, @ValorDeclarado, @ResultadoInspeccion)
            ";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@IdDeclaracion", idDeclaracion);
                        cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                        cmd.Parameters.AddWithValue("@Tipo", txtTipo.Text);
                        cmd.Parameters.AddWithValue("@ValorDeclarado", valorDeclarado);
                        cmd.Parameters.AddWithValue("@ResultadoInspeccion", resultado);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMensaje.Text = "Mercancía agregada correctamente.";
                lblMensaje.ForeColor = System.Drawing.Color.Green;

                // OPCIONAL: limpiar campos
                txtDescripcion.Text = "";
                txtTipo.Text = "";
                txtValor.Text = "";
                ddlResultado.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.ForeColor = System.Drawing.Color.Red;
            }
        }


        protected void btnFinalizar_Click(object sender, EventArgs e)
        {
            // Mantener consistencia con el resto del proyecto: ir a Inicio.aspx
            Response.Redirect("Inicio.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}