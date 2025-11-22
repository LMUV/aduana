using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Aduana.Controllers;

namespace aduana
{
    public partial class Calendario : System.Web.UI.Page
    {
        // lista en memoria para no consultar SQL en cada celda
        private static DataTable dtRevisiones;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarRevisiones();
        }

        private void CargarRevisiones()
        {
            string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();

            using (SqlConnection cnn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("PA_LISTAR_REVISION_ADUANERA", cnn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                dtRevisiones = new DataTable();
                da.Fill(dtRevisiones); // ← ya no falla
            }
        }

        protected void calRevisiones_DayRender(object sender, System.Web.UI.WebControls.DayRenderEventArgs e)
        {
            if (dtRevisiones == null || dtRevisiones.Rows.Count == 0)
                return;

            DateTime fechaCelda = e.Day.Date;

            // Filtra filas según fecha (inicio del día → siguiente día)
            DataRow[] eventos = dtRevisiones.Select(
                $"FechaRevision >= #{fechaCelda:yyyy-MM-dd}# AND FechaRevision < #{fechaCelda.AddDays(1):yyyy-MM-dd}#"
            );

            if (eventos.Length > 0)
            {
                foreach (var row in eventos)
                {
                    string inspector = row["inspector"].ToString();
                    string mercancia = row["Descripcion"].ToString();
                    string resultado = row["Resultado"].ToString().Trim().ToLower();

                    // Selección del color según el resultado
                    string colorFondo = "#ffefba"; // por defecto
                    string colorBorde = "#e0c97f";

                    if (resultado == "requiere inspeccion" || resultado == "requiere inspección")
                    {
                        colorFondo = "#ffe58a"; // amarillo
                        colorBorde = "#e6c45a";
                    }
                    else if (resultado == "aprobado")
                    {
                        colorFondo = "#b7f7a5"; // verde
                        colorBorde = "#7ac96c";
                    }
                    else if (resultado == "incautacion" || resultado == "incautación")
                    {
                        colorFondo = "#ff9a9a"; // rojo
                        colorBorde = "#c75a5a";
                    }

                    var lbl = new System.Web.UI.WebControls.Label();
                    lbl.Text =
                        $"<div style='padding:6px;" +
                        $"border-radius:8px;" +
                        $"margin-top:6px;" +
                        $"font-size:13px;" +
                        $"font-family:Segoe UI, sans-serif;" +
                        $"background:{colorFondo};" +
                        $"border:1px solid {colorBorde};" +
                        $"text-align:left;'>" +
                        $"<b>Inspector:</b> {inspector}<br/>" +
                        $"<b>Mercancía:</b> {mercancia}<br/>" +
                        $"<b>Resultado:</b> {row["Resultado"]}" +
                        $"</div>";

                    e.Cell.Controls.Add(lbl);
                }

                // resaltar la celda con evento
                e.Cell.BackColor = System.Drawing.Color.FromArgb(235, 245, 255);
            }
        }


        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
