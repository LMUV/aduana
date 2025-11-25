using aduana.Models;
using Aduana.Controllers;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using static System.Windows.Forms.MonthCalendar;


namespace Aduana
{
    public partial class Estados_frm : Page
    {


        string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {




                Inspectores();
                Declaraciones();

                CargarResultadoInspeccion();



                string id = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(id))
                {
                    CargarDatoInspeccion(id);
                }
            }
        }



        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                // ---------------------------------------------
                // VALIDAR ID DECLARACIÓN (OBLIGATORIO)
                // ---------------------------------------------
                if (string.IsNullOrWhiteSpace(ddldeclaracion.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe seleccionar una declaración.";
                    return;
                }

                using (SqlConnection cnn = new SqlConnection(conexion))
                {
                    cnn.Open();
                    using (SqlTransaction tran = cnn.BeginTransaction())
                    {
                        try
                        {
                            int codigorevision = 0;
                            bool revisionExiste = false;

                            // ---------------------------------------------
                            // SI HAY CÓDIGO → ES UPDATE
                            // SI NO HAY CÓDIGO → ES INSERT
                            // ---------------------------------------------
                            if (!string.IsNullOrWhiteSpace(txtCodigoInterno.Text) &&
                                int.TryParse(txtCodigoInterno.Text, out codigorevision))
                            {
                                using (SqlCommand cmdChk = new SqlCommand(
                                    "SELECT COUNT(*) FROM RevisionAduanera WHERE IdRevision=@id",
                                    cnn, tran))
                                {
                                    cmdChk.Parameters.AddWithValue("@id", codigorevision);
                                    revisionExiste = (int)cmdChk.ExecuteScalar() > 0;
                                }
                            }

                            // Convertir fecha
                            object fechaRevision = DBNull.Value;
                            if (!string.IsNullOrWhiteSpace(txtfecha.Text) &&
                                DateTime.TryParse(txtfecha.Text, out DateTime fecha))
                            {
                                fechaRevision = fecha;
                            }

                            // =============================================
                            // UPDATE
                            // =============================================
                            if (revisionExiste)
                            {
                                using (SqlCommand cmdUpd = new SqlCommand(@"
                        UPDATE RevisionAduanera
                        SET 
                            FechaRevision = @FechaRevision,
                            Resultado     = @Resultado,
                            InspectorId   = @InspectorId,
                            Observaciones = @Observaciones
                        WHERE IdRevision = @IdRevision",
                                    cnn, tran))
                                {
                                    cmdUpd.Parameters.AddWithValue("@IdRevision", codigorevision);
                                    cmdUpd.Parameters.AddWithValue("@FechaRevision", fechaRevision);
                                    cmdUpd.Parameters.AddWithValue("@Resultado", ddlresultado.SelectedValue);
                                    cmdUpd.Parameters.AddWithValue("@InspectorId", ddlreponsable.SelectedValue);
                                    cmdUpd.Parameters.AddWithValue("@Observaciones", txtobservar.Text.Trim());

                                    cmdUpd.ExecuteNonQuery();
                                }

                                lblMensaje.ForeColor = System.Drawing.Color.Green;
                                lblMensaje.Text = "Revisión actualizada correctamente.";
                            }
                            else
                            {
                                // =============================================
                                // INSERT  (SIN IdRevision → IDENTITY)
                                // =============================================
                                using (SqlCommand cmdIns = new SqlCommand(@"
                        INSERT INTO RevisionAduanera(
                            IdDeclaracion,
                            FechaRevision,
                            Resultado,
                            InspectorId,
                            Observaciones
                        ) VALUES (
                            @IdDeclaracion,
                            @FechaRevision,
                            @Resultado,
                            @InspectorId,
                            @Observaciones
                        )",
                                    cnn, tran))
                                {
                                    cmdIns.Parameters.AddWithValue("@IdDeclaracion", ddldeclaracion.SelectedValue);
                                    cmdIns.Parameters.AddWithValue("@FechaRevision", fechaRevision);
                                    cmdIns.Parameters.AddWithValue("@Resultado", ddlresultado.SelectedValue);
                                    cmdIns.Parameters.AddWithValue("@InspectorId", ddlreponsable.SelectedValue);
                                    cmdIns.Parameters.AddWithValue("@Observaciones", txtobservar.Text.Trim());

                                    cmdIns.ExecuteNonQuery();
                                }

                                lblMensaje.ForeColor = System.Drawing.Color.Green;
                                lblMensaje.Text = "Revisión registrada correctamente.";
                            }

                            tran.Commit();
                        }
                        catch (Exception)
                        {
                            tran.Rollback();
                            throw;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensaje.ForeColor = System.Drawing.Color.Red;
                lblMensaje.Text = "Error al guardar: " + ex.Message;
            }
        }







        private void Inspectores()
        {
            using (SqlConnection cnn = new SqlConnection(conexion))
            {
                string query = "SELECT  intCodUsuario,strNomApellidos FROM  tblUsuarios where blnActivo=1";
                using (SqlCommand cmd = new SqlCommand(query, cnn))
                {
                    cnn.Open();
                    ddlreponsable.DataSource = cmd.ExecuteReader();
                    ddlreponsable.DataTextField = "strNomApellidos";
                    ddlreponsable.DataValueField = "intCodUsuario";
                    ddlreponsable.DataBind();
                }
                ddlreponsable.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione El Inspector--", "0"));
            }
        }

        private void Declaraciones()
        {
            using (SqlConnection cnn = new SqlConnection(conexion))
            {
                string query = "SELECT  d.IdDeclaracion as decla ,p.Nombre+' '+p.Apellido+': '+m.Descripcion as declaracion FROM  DeclaracionAduanera as d inner join Mercancia as m on m.IdDeclaracion=d.IdDeclaracion inner join pasajero as p on p.IdPasajero=d.IdPasajero where EstadoDeclaracion<>'Incautada' or  EstadoDeclaracion<>'Liberada' ";
                using (SqlCommand cmd = new SqlCommand(query, cnn))
                {
                    cnn.Open();
                    ddldeclaracion.DataSource = cmd.ExecuteReader();
                    ddldeclaracion.DataTextField = "declaracion";
                    ddldeclaracion.DataValueField = "decla";
                    ddldeclaracion.DataBind();
                }
                ddldeclaracion.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione la declaración--", "0"));
            }
        }



        private void CargarResultadoInspeccion()
        {
            ddlresultado.Items.Clear();
            ddlresultado.Items.Add(new ListItem("Seleccione el Resultado Final", ""));
            ddlresultado.Items.Add(new ListItem("Requiere Inspección", "Requiere Inspección"));
            ddlresultado.Items.Add(new ListItem("Aprobado", "Aprobado"));
            ddlresultado.Items.Add(new ListItem("Incautación", "Incautación"));
        }




        private void CargarDatoInspeccion(string Id)
        {
            using (SqlConnection cnn = new SqlConnection(conexion))
            {
                cnn.Open();

                string query = @"
SELECT 
    r.IdRevision AS IdRevision,
    dh.IdDeclaracion AS IdDeclaracion,
    dh.EstadoDeclaracion AS EstadoDeclaracion,

    r.FechaRevision,
    us.intCodUsuario,
    r.Resultado AS Resultado,
    us.strNomApellidos,

    CASE 
         WHEN r.Resultado = 'Incautación'  THEN r.Observaciones
         WHEN r.Resultado = 'Aprobado'     THEN r.Observaciones
         ELSE ''
    END AS Observaciones

FROM RevisionAduanera AS r
INNER JOIN DeclaracionAduanera AS dh 
    ON r.IdDeclaracion = dh.IdDeclaracion
INNER JOIN tblUsuarios AS us 
    ON r.InspectorId = us.intCodUsuario
WHERE r.IdRevision = @Id;
";

                SqlCommand cmd = new SqlCommand(query, cnn);
                cmd.Parameters.AddWithValue("@Id", Id);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtCodigoInterno.Text = reader["IdRevision"].ToString();
                        ddldeclaracion.Text = reader["IdDeclaracion"].ToString();

                        // Inspector
                        ddlreponsable.SelectedValue = reader["intCodUsuario"].ToString();

                        // Resultado
                        ddlresultado.SelectedValue = reader["Resultado"].ToString();

                        // Fecha
                        txtfecha.Text = reader["FechaRevision"] != DBNull.Value
                            ? Convert.ToDateTime(reader["FechaRevision"]).ToString("yyyy-MM-dd")
                            : "";

                        // Observaciones
                        txtobservar.Text = reader["Observaciones"].ToString();
                    }
                }
            }
        }


        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCodigoInterno.Text))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No hay IdRevision seleccionado.');", true);
                    return;
                }

                int idRevision = Convert.ToInt32(txtCodigoInterno.Text);

                string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();

                using (SqlConnection cnn = new SqlConnection(conexion))
                using (SqlCommand cmd = new SqlCommand("PA_ELIMINAR_REVISION", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@IdRevision", idRevision);

                    cnn.Open();
                    int filasAfectadas = cmd.ExecuteNonQuery();

                    if (filasAfectadas > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Registro eliminado correctamente.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No se encontró el registro.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }



        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Estados.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }


        protected void LimpiarCampos(object sender, EventArgs e)
        {
            txtCodigoInterno.Text = "";
            ddldeclaracion.SelectedIndex = 0;

            txtobservar.Text = "";
            ddlreponsable.SelectedIndex = 0;
            txtfecha.Text = "";

            ddlresultado.SelectedIndex = 0;



        }








    }
}