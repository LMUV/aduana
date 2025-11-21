using aduana.Models;
using Aduana.Controllers;

using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace aduana
{
    public partial class Calendario : Page
    {
        private readonly string conexion = ConfigurationManager.ConnectionStrings["CadenaConexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UsuarioNombre"] != null)
                {
                    lblUsuario.Text = Session["UsuarioNombre"].ToString();
                   
                    
                    

                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }



        [WebMethod]
        public static List<object> GetMantenimientos()
        {
            var lista = new List<object>();
            string conexion = ConfigurationManager.ConnectionStrings["CadenaConexion"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("PA_LISTAR_REVISION_ADUANERA", cnn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cnn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string color = "#999"; // temporal

                        string resultado = dr["Resultado"].ToString().Trim();

                        if (resultado == "Aprobado")
                            color = "green";
                        else if (resultado == "Requiere Inspección")
                            color = "yellow";
                        else if (resultado == "Incautación")
                            color = "red";

                        lista.Add(new
                        {
                            id = dr["IdDeclaracion"],
                            title = dr["Descripcion"].ToString(),
                            start = Convert.ToDateTime(dr["FechaRevision"]).ToString("s"),
                            end = Convert.ToDateTime(dr["FechaRevision"]).ToString("s"),
                            allDay = false,
                            backgroundColor = color,
                            borderColor = color
                        });
                    }
                }
            }

            return lista;
        }






    }
}