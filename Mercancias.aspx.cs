using aduana.Models;
using Aduana.Controllers;

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aduana
{
    public partial class Mercancias : Page
    {
        string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();

        CtrlDashboard cad = new CtrlDashboard();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UsuarioNombre"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                lblUsuario.Text = Session["UsuarioNombre"].ToString();

                string idDeclaracion = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(idDeclaracion))
                {
                    // Solo carga las mercancías de la declaración seleccionada
                    CargarMercancias(idDeclaracion);
                }
                else
                {
                    // Si no hay id, carga todas
                    Cargarmerca();
                }
            }

        }


        private void CargarMercancias(string idDeclaracion)
        {
            try
            {
                DataTable dt = new DataTable();

                using (SqlConnection cnn = new SqlConnection(conexion))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter("PA_LISTAR_MERCANCIAS_POR_DECLARACION", cnn))
                    {
                        da.SelectCommand.CommandType = CommandType.StoredProcedure;
                        da.SelectCommand.Parameters.AddWithValue("@IdDeclaracion", idDeclaracion);

                        da.Fill(dt);
                    }
                }

                gvEquipos.DataSource = dt;
                gvEquipos.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al cargar mercancías de la declaración: " + ex.Message);
            }
        }




        private void Cargarmerca()
        {
            DataTable equipos = Listar();
            gvEquipos.DataSource = equipos;
            gvEquipos.DataBind();
        }

        //  Buscar por código del equipo




        //  Listar todos los equipos al inicio
        private DataTable Listar()
        {
            DataTable dt = new DataTable();
            try
            {
                CtrlCadConexion cad = new CtrlCadConexion();
                using (SqlConnection cnn = new SqlConnection(cad.CadenaConexion()))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter("PA_LISTAR_MERCANCIAS", cnn))
                    {
                        da.SelectCommand.CommandType = CommandType.StoredProcedure;
                        da.Fill(dt);
                    }
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error al listar mercancias declaradas: " + ex.Message);
            }
            return dt;
        }



    }
}
