using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using Aduana.Controllers;

namespace aduana
{
    public partial class Declaraciones : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPasajeros();
                LoadVuelos();
                txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            // Asegura que el handler esté registrado aunque algo falle en el markup
            btnCrear.Click += btnCrear_Click;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Permitir renderizado programático si hace falta.
        }

        private void LoadPasajeros()
        {
            const string sql = "SELECT IdPasajero, Nombre + ' ' + Apellido AS NombreCompleto FROM Pasajero ORDER BY Nombre, Apellido";
            var dt = new DataTable();
            try
            {
                var cad = new CtrlCadConexion();
                using (var cn = new SqlConnection(cad.CadenaConexion()))
                using (var cmd = new SqlCommand(sql, cn))
                {
                    cn.Open();
                    using (var rdr = cmd.ExecuteReader())
                        dt.Load(rdr);
                }

                ddlPasajero.DataSource = dt;
                ddlPasajero.DataTextField = "NombreCompleto";
                ddlPasajero.DataValueField = "IdPasajero";
                ddlPasajero.DataBind();
                ddlPasajero.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", "0"));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadPasajeros: " + ex.Message);
                lblMensaje.Text = "Error al cargar pasajeros.";
            }
        }

        private void LoadVuelos()
        {
            const string sql = "SELECT IdVuelo, NumeroVuelo + ' - ' + Origen + ' > ' + Destino AS VueloInfo FROM Vuelo ORDER BY FechaLlegada DESC";
            var dt = new DataTable();
            try
            {
                var cad = new CtrlCadConexion();
                using (var cn = new SqlConnection(cad.CadenaConexion()))
                using (var cmd = new SqlCommand(sql, cn))
                {
                    cn.Open();
                    using (var rdr = cmd.ExecuteReader())
                        dt.Load(rdr);
                }

                ddlVuelo.DataSource = dt;
                ddlVuelo.DataTextField = "VueloInfo";
                ddlVuelo.DataValueField = "IdVuelo";
                ddlVuelo.DataBind();
                ddlVuelo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", "0"));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadVuelos: " + ex.Message);
                lblMensaje.Text = "Error al cargar vuelos.";
            }
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            // Indicador rápido para el usuario y para depuración
            lblMensaje.Text = "Procesando...";
            System.Diagnostics.Debug.WriteLine("btnCrear_Click: inicio");

            if (!int.TryParse(ddlPasajero.SelectedValue, out var idPasajero) || idPasajero == 0 ||
                !int.TryParse(ddlVuelo.SelectedValue, out var idVuelo) || idVuelo == 0)
            {
                lblMensaje.Text = "Seleccione pasajero y vuelo.";
                System.Diagnostics.Debug.WriteLine("btnCrear_Click: pasajero o vuelo no seleccionado");
                return;
            }

            if (!DateTime.TryParse(txtFecha.Text, out var fecha))
                fecha = DateTime.Now;

            var estado = ddlEstado.SelectedValue;
            var obs = txtObservaciones.Text?.Trim();
            object obsParam = string.IsNullOrWhiteSpace(obs) ? (object)DBNull.Value : obs;

            int newId = 0;
            var cadConn = new CtrlCadConexion();
            using (var cn = new SqlConnection(cadConn.CadenaConexion()))
            {
                cn.Open();
                // Primero intentamos SP con OUTPUT
                try
                {
                    using (var cmd = new SqlCommand("PA_INSERT_DECLARACION", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@IdPasajero", idPasajero);
                        cmd.Parameters.AddWithValue("@IdVuelo", idVuelo);
                        cmd.Parameters.AddWithValue("@FechaDeclaracion", fecha);
                        cmd.Parameters.AddWithValue("@EstadoDeclaracion", estado);
                        cmd.Parameters.AddWithValue("@Observaciones", obsParam);

                        var outParam = new SqlParameter("@NewId", SqlDbType.Int) { Direction = ParameterDirection.Output };
                        cmd.Parameters.Add(outParam);

                        cmd.ExecuteNonQuery();

                        if (outParam.Value != null && outParam.Value != DBNull.Value)
                        {
                            int.TryParse(outParam.Value.ToString(), out newId);
                        }

                        System.Diagnostics.Debug.WriteLine("PA_INSERT_DECLARACION output @NewId = " + newId);
                    }
                }
                catch (Exception exSp)
                {
                    System.Diagnostics.Debug.WriteLine("Error al ejecutar PA_INSERT_DECLARACION: " + exSp.Message);
                }

                // Si no obtuvimos id, intentamos fallback INSERT paramatrizado y recuperar SCOPE_IDENTITY
                if (newId == 0)
                {
                    try
                    {
                        string sqlInsert = @"
INSERT INTO DeclaracionAduanera (IdPasajero, IdVuelo, FechaDeclaracion, EstadoDeclaracion, Observaciones)
VALUES (@IdPasajero, @IdVuelo, @FechaDeclaracion, @EstadoDeclaracion, @Observaciones);
SELECT CAST(SCOPE_IDENTITY() AS INT);";

                        using (var cmd2 = new SqlCommand(sqlInsert, cn))
                        {
                            cmd2.Parameters.AddWithValue("@IdPasajero", idPasajero);
                            cmd2.Parameters.AddWithValue("@IdVuelo", idVuelo);
                            cmd2.Parameters.AddWithValue("@FechaDeclaracion", fecha);
                            cmd2.Parameters.AddWithValue("@EstadoDeclaracion", estado);
                            cmd2.Parameters.AddWithValue("@Observaciones", obsParam);

                            object obj = cmd2.ExecuteScalar();
                            if (obj != null && obj != DBNull.Value)
                                int.TryParse(obj.ToString(), out newId);

                            System.Diagnostics.Debug.WriteLine("Fallback INSERT SCOPE_IDENTITY = " + newId);
                        }
                    }
                    catch (Exception exIns)
                    {
                        System.Diagnostics.Debug.WriteLine("Error en fallback INSERT: " + exIns.Message);
                    }
                }
            } // using cn

            if (newId > 0)
            {
                System.Diagnostics.Debug.WriteLine("btnCrear_Click: redirigiendo a AgregarMercancia.aspx?IdDeclaracion=" + newId);
                // Redirección segura
                Response.Redirect("AgregarMercancia.aspx?IdDeclaracion=" + newId, false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            else
            {
                lblMensaje.Text = "No fue posible crear la declaración. Revisa el log (Output) del servidor.";
                System.Diagnostics.Debug.WriteLine("btnCrear_Click: newId == 0, no se redirige");
            }
        }
    }
}