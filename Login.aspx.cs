using System;
using System.Data;
using System.Data.SqlClient;

namespace Aduana
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string contrasena = txtContrasena.Text.Trim();

            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(contrasena))
            {
                lblMensaje.Text = "Debe ingresar usuario y contraseña.";
                return;
            }

            try
            { //"Data Source=NERAK\\SQLEXPRESS;Initial Catalog=DB_INV_INTEGRADO;Integrated Security=True")
                using (SqlConnection cnn = new SqlConnection("Data Source=DESKTOP-U5A24RO\\SQLEXPRESS;Initial Catalog=SistemaAduanero;Integrated Security=True;TrustServerCertificate=True;")

                    )
                {
                    SqlCommand cmd = new SqlCommand("PA_LOGIN_USUARIO", cnn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@USUARIO", usuario);
                    cmd.Parameters.AddWithValue("@PASSWD", contrasena);

                    cnn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        // Guarda los datos del usuario en sesión
                        Session["UsuarioNombre"] = dr["strNomApellidos"].ToString();
                        Session["UsuarioCargo"] = dr["strCargo"].ToString();
                        Session["UsuarioId"] = dr["intCodUsuario"].ToString();
                        

                        Response.Redirect("Inicio.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        lblMensaje.Text = "Usuario o contraseña incorrectos o inactivos.";
                    }

                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al intentar iniciar sesión: " + ex.Message;
            }
        }
    }
}
