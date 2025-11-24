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
                // Validar ID de revisión
                if (string.IsNullOrWhiteSpace(txtCodigoInterno.Text) ||
                    !int.TryParse(txtCodigoInterno.Text, out int codigorevision))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Código Revisión inválido.";
                    return;
                }

                // Validar Id Declaración
                if (string.IsNullOrWhiteSpace(txtdeclaracion.Text))
                {
                    lblMensaje.ForeColor = System.Drawing.Color.Red;
                    lblMensaje.Text = "Debe ingresar el ID de la declaración.";
                    return;
                }

                using (SqlConnection cnn = new SqlConnection(conexion))
                {
                    cnn.Open();
                    using (SqlTransaction tran = cnn.BeginTransaction())
                    {
                        try
                        {
                            bool revisionExiste;

                            // Verificar si existe la revisión
                            using (SqlCommand cmdChk = new SqlCommand(
                                "SELECT COUNT(*) FROM RevisionAduanera WHERE IdRevision=@id",
                                cnn, tran))
                            {
                                cmdChk.Parameters.AddWithValue("@id", codigorevision);
                                revisionExiste = (int)cmdChk.ExecuteScalar() > 0;
                            }

                            // Convertir fecha
                            object fechaRevision;
                            if (string.IsNullOrWhiteSpace(txtfecha.Text))
                                fechaRevision = DBNull.Value;
                            else if (DateTime.TryParse(txtfecha.Text, out DateTime fecha))
                                fechaRevision = fecha;
                            else
                                throw new Exception("Formato de fecha inválido.");

                            // ---------------------------------------------------------
                            // UPDATE
                            // ---------------------------------------------------------
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
                                // ---------------------------------------------------------
                                // INSERT
                                // ---------------------------------------------------------
                                using (SqlCommand cmdIns = new SqlCommand(@"

                            INSERT INTO RevisionAduanera(
                               
                                IdDeclaracion,
                                FechaRevision,
                                Resultado,
                                InspectorId,
                                Observaciones
                            ) VALUES (
                                
                                @IdDeclaracion,
                               ISNULL(@FechaRevision, ''), 
                                ISNULL(@Resultado, 'Requiere Inspección'),
                               ISNULL(@InspectorId, 1),
                                ISNULL(@Observaciones, '')
                            )",
                                    cnn, tran))
                                {
                                    cmdIns.Parameters.AddWithValue("@IdDeclaracion",
    string.IsNullOrWhiteSpace(txtdeclaracion.Text) ? (object)DBNull.Value : txtdeclaracion.Text);

                                    cmdIns.Parameters.AddWithValue("@FechaRevision",
                                        string.IsNullOrWhiteSpace(txtfecha.Text) ? (object)DBNull.Value : Convert.ToDateTime(txtfecha.Text));

                                    cmdIns.Parameters.AddWithValue("@Resultado",
                                        string.IsNullOrWhiteSpace(ddlresultado.SelectedValue) ? (object)DBNull.Value : ddlresultado.SelectedValue);

                                    cmdIns.Parameters.AddWithValue("@InspectorId",
                                        string.IsNullOrWhiteSpace(ddlreponsable.SelectedValue) ? (object)DBNull.Value : ddlreponsable.SelectedValue);

                                    cmdIns.Parameters.AddWithValue("@Observaciones",
                                        string.IsNullOrWhiteSpace(txtobservar.Text) ? (object)DBNull.Value : txtobservar.Text);


                                  

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
                string query ="SELECT  intCodUsuario,strNomApellidos FROM  tblUsuarios where blnActivo=1";
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
                        txtdeclaracion.Text = reader["IdDeclaracion"].ToString();

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
            txtdeclaracion.Text = "";

            txtobservar.Text = "";
            ddlreponsable.SelectedIndex = 0;
            txtfecha.Text = "";

            ddlresultado.SelectedIndex = 0;
           

         
        }


        





    }
}
