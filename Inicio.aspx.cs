using aduana.Models;
using Aduana.Controllers;

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Aduana
{
    public partial class Inicio : Page
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
                    CargarEquipos();

                    int aux = cad.Aprobados();
                    Label1.Text = aux.ToString();

                    int aux2 = cad.Inpeccion();
                    Label2.Text = aux2.ToString();

                    int aux3 = cad.Incautados();
                    Label3.Text = aux3.ToString();


                    
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
                CargarEquipos();
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

        private void CargarEquipos()
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
                    using (SqlDataAdapter da = new SqlDataAdapter("PA_BUSCAR_MERCANCIAS", cnn))
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
                    using (SqlDataAdapter da = new SqlDataAdapter("PA_LISTAR_MERCA_DECLARADA", cnn))
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
                string IdDeclaracion = e.CommandArgument.ToString();
                Response.Redirect("Estados_Inicio.aspx?id=" + IdDeclaracion);
            }
           

        }


    }
}
