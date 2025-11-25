using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using Aduana.Controllers;

namespace aduana
{
    public partial class AgregarMercancia : Page
    {
        private int IdDeclaracion => int.TryParse(Request.QueryString["IdDeclaracion"], out var i) ? i : 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (IdDeclaracion == 0)
                {
                    lblMensaje.Text = "Id de declaración no válido.";
                    PnlEmergencyDisable();
                    return;
                }

                lblId.Text = IdDeclaracion.ToString();
                BindMercancias();
            }
        }

        private void PnlEmergencyDisable()
        {
            // Deshabilita formulario si no hay id válido
            txtDescripcion.Enabled = txtTipo.Enabled = txtValor.Enabled = ddlResultado.Enabled = btnAgregar.Enabled = false;
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            lblMensaje.Text = string.Empty;

            var desc = txtDescripcion.Text.Trim();
            var tipo = txtTipo.Text.Trim();
            decimal? valor = null;
            if (decimal.TryParse(txtValor.Text.Trim(), out var v)) valor = v;
            var resultado = ddlResultado.SelectedValue;

            // Validación básica en servidor
            if (string.IsNullOrEmpty(desc) || string.IsNullOrEmpty(tipo))
            {
                lblMensaje.Text = "Descripción y tipo son obligatorios.";
                return;
            }

            if (IdDeclaracion == 0)
            {
                lblMensaje.Text = "No hay una declaración válida seleccionada.";
                PnlEmergencyDisable();
                return;
            }

            try
            {
                var cad = new CtrlCadConexion();
                using (var cn = new SqlConnection(cad.CadenaConexion()))
                using (var cmd = new SqlCommand("PA_INSERT_MERCANCIA", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdDeclaracion", IdDeclaracion);
                    cmd.Parameters.AddWithValue("@Descripcion", desc);
                    cmd.Parameters.AddWithValue("@Tipo", tipo);
                    if (valor.HasValue)
                        cmd.Parameters.AddWithValue("@ValorDeclarado", valor.Value);
                    else
                        cmd.Parameters.AddWithValue("@ValorDeclarado", DBNull.Value);
                    cmd.Parameters.AddWithValue("@ResultadoInspeccion", resultado ?? (object)DBNull.Value);

                    cn.Open();
                    var rows = cmd.ExecuteNonQuery();

                    if (rows <= 0)
                    {
                        lblMensaje.Text = "No se pudo guardar la mercancía.";
                        return;
                    }
                }

                // Limpiar y refrescar lista
                txtDescripcion.Text = txtTipo.Text = txtValor.Text = string.Empty;
                ddlResultado.SelectedIndex = 0;
                BindMercancias();

                lblMensaje.ForeColor = System.Drawing.Color.Green;
                lblMensaje.Text = "Mercancía agregada correctamente.";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("AgregarMercancia.btnAgregar_Click: " + ex.Message);
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar mercancía.";
            }
        }

        private void BindMercancias()
        {
            try
            {
                var cad = new CtrlCadConexion();
                using (var cn = new SqlConnection(cad.CadenaConexion()))
                using (var cmd = new SqlCommand("SELECT IdMercancia, Descripcion, Tipo, ValorDeclarado, ResultadoInspeccion FROM Mercancia WHERE IdDeclaracion = @IdDecl ORDER BY IdMercancia DESC", cn))
                {
                    cmd.Parameters.AddWithValue("@IdDecl", IdDeclaracion);
                    var dt = new DataTable();
                    cn.Open();
                    dt.Load(cmd.ExecuteReader());
                    gvMercancias.DataSource = dt;
                    gvMercancias.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("BindMercancias: " + ex.Message);
                lblMensaje.Text = "Error al cargar mercancías.";
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