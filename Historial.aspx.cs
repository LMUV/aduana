using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Aduana.Controllers;

namespace Aduana
{
    public partial class Historial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos();
            }
        }

        private void CargarDatos()
        {
            CtrlCadConexion ctrl = new CtrlCadConexion();
            string cadena = ctrl.CadenaConexion();

            using (SqlConnection conexion = new SqlConnection(cadena))
            {
                try
                {
                    conexion.Open();

                    string consulta = @"
                        SELECT 
                            IdDeclaracion,
                            IdPasajero,
                            IdVuelo,
                            CONVERT(varchar, FechaDeclaracion, 120) AS FechaDeclaracion,
                            EstadoDeclaracion,
                            Observaciones
                        FROM DeclaracionAduanera
                        ORDER BY FechaDeclaracion DESC";

                    SqlDataAdapter adaptador = new SqlDataAdapter(consulta, conexion);
                    DataTable dt = new DataTable();
                    adaptador.Fill(dt);

                    gvHistorial.DataSource = dt;
                    gvHistorial.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error al cargar los datos: " + ex.Message + "');</script>");
                }
            }
        }

        // ✅ Evento del botón "Ver"
        protected void gvHistorial_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Ver")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("Detalle.aspx?Id=" + id);
            }
        }

        // ✅ Botón de salir
        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        public override void VerifyRenderingInServerForm(System.Web.UI.Control control)
        {
        }
    }
}
