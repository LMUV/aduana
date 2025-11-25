using Aduana.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using aduana.Models;


using System.Data.SqlClient;



namespace aduana
{
    public partial class Notificaciones : System.Web.UI.Page
    {
        string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();

        CtrlDashboard cad = new CtrlDashboard();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarNotificaciones();
            }
        }
        public void CargarNotificaciones()
        {
            string query = @"SELECT IdNotificacion, IdPasajero, Tipo, Mensaje, FechaEnvio 
                     FROM Notificacion ORDER BY FechaEnvio DESC";

            using (SqlConnection con = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvNotificaciones.DataSource = dt;
                gvNotificaciones.DataBind();
            }
        }

        protected void gvNotificaciones_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNotificaciones.PageIndex = e.NewPageIndex;
            CargarNotificaciones();
        }

    }
}