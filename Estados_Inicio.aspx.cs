using Aduana.Controllers;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace aduana
{
    public partial class Estados_Inicio : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["Id"];
                if (!string.IsNullOrEmpty(id))
                {
                    CargarFichaTecnicas(id);
                }
            }
        }






        protected void btnDescargar_Click(object sender, EventArgs e)
        {
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            divFicha.RenderControl(hw);
            string html = sw.ToString();

            using (MemoryStream ms = new MemoryStream())
            {
                Document doc = new Document(PageSize.A4, 40, 40, 40, 40);
                PdfWriter writer = PdfWriter.GetInstance(doc, ms);
                doc.Open();

                using (var htmlStream = new MemoryStream(Encoding.UTF8.GetBytes(html)))
                {
                    XMLWorkerHelper.GetInstance().ParseXHtml(
                        writer,
                        doc,
                        htmlStream,
                        null,
                        Encoding.UTF8
                    );
                }

                doc.Close();

                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=FichaMercancia.pdf");
                Response.BinaryWrite(ms.ToArray());
                Response.End();
            }
        }

        private void CargarFichaTecnicas(string Id)
        {
            string conexion = new Aduana.Controllers.CtrlCadConexion().CadenaConexion();

            using (SqlConnection cnn = new SqlConnection(conexion))
            using (SqlCommand cmd = new SqlCommand("PA_FICHA_TECNICA_MERCANCIA_ID", cnn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdDeclaracion", Id);

                cnn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtPasajero.Text = reader["Pasajero"].ToString();
                        txtDocumento.Text = reader["DocumentoIdentidad"].ToString();
                        txtNacionalidad.Text = reader["Nacionalidad"].ToString();
                        txtCorreo.Text = reader["Correo"].ToString();
                        txtTelefono.Text = reader["Telefono"].ToString();

                        txtVuelo.Text = reader["NumeroVuelo"].ToString();
                        txtFechaLlegada.Text = Convert.ToDateTime(reader["FechaLlegada"]).ToString("yyyy-MM-dd HH:mm");
                        txtOrigen.Text = reader["Origen"].ToString();
                        txtDestino.Text = reader["Destino"].ToString();

                        txtIdDeclaracion.Text = reader["IdDeclaracion"].ToString();
                        txtFechaDeclaracion.Text = Convert.ToDateTime(reader["FechaDeclaracion"]).ToString("yyyy-MM-dd HH:mm");
                        txtEstadoDeclaracion.Text = reader["EstadoDeclaracion"].ToString();
                        txtObsDeclaracion.Text = reader["ObsDeclaracion"].ToString();

                        txtDescripcion.Text = reader["MercanciaDescripcion"].ToString();
                        txtTipo.Text = reader["TipoMercancia"].ToString();
                        txtValor.Text = reader["ValorDeclarado"].ToString();
                        txtResultadoInspeccion.Text = reader["ResultadoInspeccion"].ToString();

                        txtFechaRevision.Text = reader["FechaRevision"].ToString();
                        txtResultadoRevision.Text = reader["ResultadoRevision"].ToString();
                        txtInspector.Text = reader["Inspector"].ToString();
                        txtObsRevision.Text = reader["ObsRevision"].ToString();
                    }
                }
            }
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inicio.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
        }
    }
}