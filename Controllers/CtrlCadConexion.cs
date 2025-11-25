using System;

namespace Aduana.Controllers
{
    public class CtrlCadConexion
    {
        public string CadenaConexion()
        {
            // Conexión local a SQL Express usando instancia por defecto
            string cad ="Data Source=HISADESARROLLO\\SQLEXPRESS;Initial Catalog=Sistema;User ID=adminaduanaaa;Password=Administrador1;Encrypt=False;TrustServerCertificate=True;";
            return cad;
        }
    }
}
