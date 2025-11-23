using Aduana.Controllers;
using aduana.Models;
using Microsoft.Data.SqlClient;
using System;
using System.Data;


namespace Aduana.Controllers
{
    public class CtrlDashboard
    {
        


      
        public int Aprobados()
        {
            int total = 0;

            try
            {
                CtrlCadConexion cad = new CtrlCadConexion();
                using (SqlConnection cnn = new SqlConnection(cad.CadenaConexion()))
                using (SqlCommand cmd = new SqlCommand("PA_APROBADOS", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cnn.Open();


                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                        total = Convert.ToInt32(result);
                }
            }
            catch (Exception ex)
            {
                
                throw new Exception("Error al obtener la carga Aprobada: " + ex.Message, ex);
            }

            return total;
        }


        public int Inpeccion()
        {
            int total = 0;

            try
            {
                CtrlCadConexion cad = new CtrlCadConexion();
                using (SqlConnection cnn = new SqlConnection(cad.CadenaConexion()))
                using (SqlCommand cmd = new SqlCommand("PA_INSPECCION", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cnn.Open();


                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                        total = Convert.ToInt32(result);
                }
            }
            catch (Exception ex)
            {
               
                throw new Exception("Error al obtener la Carga que esta en Inspeccion : " + ex.Message, ex);
            }

            return total;
        }

        public int Incautados()
        {
            int total = 0;

            try
            {
                CtrlCadConexion cad = new CtrlCadConexion();
                using (SqlConnection cnn = new SqlConnection(cad.CadenaConexion()))
                using (SqlCommand cmd = new SqlCommand("PA_INCAUTADO", cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cnn.Open();


                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                        total = Convert.ToInt32(result);
                }
            }
            catch (Exception ex)
            {
                 
                throw new Exception("Error al obtener la Carga Incautada: " + ex.Message, ex);
            }

            return total;
        }






    }
}
