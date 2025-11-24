using aduana.Models;
using Aduana.Controllers;

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aduana
{
    public partial class Estados : Page
    {
        CtrlDashboard cad = new CtrlDashboard();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //  Verificar si hay sesión activa
                if (Session["UsuarioNombre"] != null)
                {
                    lblUsuario.Text = Session["UsuarioNombre"].ToString();



                    //  Cargar listado de equipos al iniciar
                    CargarEstados();


                    
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string texto = txtBuscar.Text.Trim();

            if (string.IsNullOrEmpty(texto))
            {
                // Si no hay texto, volver a listar todos los equipos
                CargarEstados();
                return;
            }

            DataTable dt = new DataTable();

            //  Detectar si el texto ingresado es un número
            if (int.TryParse(texto, out int codigo))
            {
                dt = BuscarPorCodigo(codigo);
            }
            else
            {
                dt = BuscarPorNombre(texto);
               
            }

            gvEquipos.DataSource = dt;
            gvEquipos.DataBind();
        }

        private void CargarEstados()
        {
            DataTable equipos = ListarEquipos();
            gvEquipos.DataSource = equipos;
            gvEquipos.DataBind();
        }

        //  Buscar por código del equipo
        private DataTable BuscarPorCodigo(int codigo)
        {
            return EjecutarBusqueda("@BUSQUEDA", codigo.ToString());
        }

        //  Buscar por nombre del equipo
        private DataTable BuscarPorNombre(string nombre)
        {
            return EjecutarBusqueda("@BUSQUEDA", nombre);
        }

       

        //  Método genérico para ejecutar el procedimiento
        private DataTable EjecutarBusqueda(string parametro, string valor)
        {
            DataTable dt = new DataTable();
            try
            {
                CtrlCadConexion cad = new CtrlCadConexion();
                using (SqlConnection cnn = new SqlConnection(cad.CadenaConexion()))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter("PA_BUSCAR_ESTADOS", cnn))
                    {
                        da.SelectCommand.CommandType = CommandType.StoredProcedure;
                        da.SelectCommand.Parameters.Add(parametro, SqlDbType.VarChar, 100).Value = valor;
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                // En caso de error, mostrar un mensaje en consola del servidor
                System.Diagnostics.Debug.WriteLine("Error en búsqueda: " + ex.Message);
            }
            return dt;
        }
       

        //  Listar todos los equipos al inicio
        private DataTable ListarEquipos()
        {
            DataTable dt = new DataTable();
            try
            {
                CtrlCadConexion cad = new CtrlCadConexion();
                using (SqlConnection cnn = new SqlConnection(cad.CadenaConexion()))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter("PA_LISTAR_ESTADOS", cnn))
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

        protected void gvEstados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Ver")
            {
                string IdRevision = e.CommandArgument.ToString();

           
                Response.Redirect("Estados_frm.aspx?id=" + IdRevision);
            }
        }


        protected void btnEstados_Click(object sender, EventArgs e)
        {
            Response.Redirect("Estados_frm.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }


    }
}
