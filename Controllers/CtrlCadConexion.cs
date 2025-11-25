using System;

namespace Aduana.Controllers
{
    public class CtrlCadConexion
    {
        public string CadenaConexion()
        {
            // Conexión local a SQL Express usando instancia por defecto
            string cad = "Data Source=NERAK\\SQLEXPRESS;Initial Catalog=SistemaAduanero;Integrated Security=True; TrustServerCertificate=True;";
            return cad;
        }
    }
}
