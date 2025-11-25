using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using Aduana.Controllers;
using System.Web.UI.WebControls;
namespace aduana
{
    public partial class Declaraciones : Page
    {
        string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPasajeros();
                LoadVuelos();
             
            }
        }

     

       

        private void LoadPasajeros()
        {
            using (SqlConnection cnn = new SqlConnection(conexion))
            {
                string query = "SELECT IdPasajero, Nombre + ' ' + Apellido AS NombreCompleto FROM Pasajero ORDER BY Nombre, Apellido";
                using (SqlCommand cmd = new SqlCommand(query, cnn))
                {
                    cnn.Open();
                    ddlPasajero.DataSource = cmd.ExecuteReader();
                    ddlPasajero.DataTextField = "NombreCompleto";
                    ddlPasajero.DataValueField = "IdPasajero";
                    ddlPasajero.DataBind();
                }
                ddlPasajero.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione el Pasajero--", "0"));
            }
        }
        private void LoadVuelos()
        {
            using (SqlConnection cnn = new SqlConnection(conexion))
            {
                string query = "SELECT IdVuelo, NumeroVuelo + ' - ' + Origen + ' > ' + Destino AS VueloInfo FROM Vuelo ORDER BY FechaLlegada DESC";
                using (SqlCommand cmd = new SqlCommand(query, cnn))
                {
                    cnn.Open();
                    ddlVuelo.DataSource = cmd.ExecuteReader();
                    ddlVuelo.DataTextField = "VueloInfo";
                    ddlVuelo.DataValueField = "IdVuelo";
                    ddlVuelo.DataBind();
                }
                ddlVuelo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione el Vuelo--", "0"));
            }
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                int nuevoID = 0;

                using (SqlConnection con = new SqlConnection(conexion))
                {
                    using (SqlCommand cmd = new SqlCommand("PA_INSERT_DECLARACION", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@IdPasajero", ddlPasajero.SelectedValue);
                        cmd.Parameters.AddWithValue("@IdVuelo", ddlVuelo.SelectedValue);
                        cmd.Parameters.AddWithValue("@FechaDeclaracion", Convert.ToDateTime(txtFecha.Text));
                        cmd.Parameters.AddWithValue("@EstadoDeclaracion", ddlEstado.SelectedValue);

                        if (string.IsNullOrWhiteSpace(txtObservaciones.Text))
                            cmd.Parameters.AddWithValue("@Observaciones", DBNull.Value);
                        else
                            cmd.Parameters.AddWithValue("@Observaciones", txtObservaciones.Text);

                        SqlParameter outputId = new SqlParameter("@NuevoID", SqlDbType.Int);
                        outputId.Direction = ParameterDirection.Output;
                        cmd.Parameters.Add(outputId);

                        con.Open();
                        cmd.ExecuteNonQuery();

                        nuevoID = Convert.ToInt32(outputId.Value);
                    }
                }

                // 🔥 REDIRIGIR CON EL ID REAL
                Response.Redirect("AgregarMercancia.aspx?id=" + nuevoID);
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.ForeColor = System.Drawing.Color.Red;
            }
        }


    }
}