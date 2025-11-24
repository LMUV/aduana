using System;

namespace Aduana.Controllers
{
    public class CtrlCadConexion
    {
        public string CadenaConexion()
        {
            // Conexión local a SQL Express usando instancia por defecto
            string cad = "Data Source=DESKTOP-U5A24RO\\SQLEXPRESS;Initial Catalog=SistemaAduanero1;Integrated Security=True; TrustServerCertificate=True;";
            return cad;
        }
    }
}
