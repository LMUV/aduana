using System;
using System.Data;
using Microsoft.Data.SqlClient;
namespace Aduana.Controllers
{
    public class CtrlConexion
    {
        



            String CadenaConexion;
            SqlConnection objConexion;
            String comandoSql;

            //constructor vacio, inicializa las variables en null
            public CtrlConexion()
            {
                this.CadenaConexion = null;
                this.objConexion = null;
                this.comandoSql = null;
            }

            //constructor sobrecargado, inicializa las variables de acuerdo a los parametros que le envien 
            public CtrlConexion(string cc, SqlConnection con, string comandoSql)
            {
                this.CadenaConexion = cc;
                this.objConexion = con;
                this.comandoSql = comandoSql;
            }

            //metodo para abrir la conexion con la base de datos 
            public String abrirBaseDatos(String CadenaConexion)
            {
                String msg = "ok";
                try
                {
                    objConexion = new SqlConnection(CadenaConexion);
                    objConexion.Open();
                }
                catch (Exception objExp)
                {
                    //la variable msg local, captura el mensaje de error
                    msg = objExp.Message;
                }
                return msg;
            }

            //metodo para cerrar la conexion con la base de datos
            public String cerrarBaseDatos()
            {
                String msg = "ok";
                try
                {
                    objConexion.Close();
                }
                catch (Exception objExp)
                {
                    msg = objExp.Message;
                }
                return msg;
            }

            //metodo para ejecutar comandos SQL de INSERT, UPDATE y DELETE
            public String ejecutarComandoSql(String comandoSql)
            {
                String msg = "ok";
                try
                {
                    SqlCommand objSqlCom = new SqlCommand(comandoSql, objConexion);
                    objSqlCom.ExecuteNonQuery();
                }
                catch (Exception objExp)
                {
                    msg = objExp.Message;
                }
                return msg;
            }

            //metodo para ejecutar comando SQL SELECT
            public DataSet ejecutarConsultaSql(String consultaSql)
            {
                String msg = "ok";
                DataSet objDataSet = new DataSet();
                try
                {
                    SqlDataAdapter objDataAdapter = new SqlDataAdapter(consultaSql, objConexion);
                    objDataAdapter.Fill(objDataSet);
                }
                catch (Exception objExp)
                {
                    msg = objExp.Message;
                }
                return objDataSet;
            }
        
    }
}

