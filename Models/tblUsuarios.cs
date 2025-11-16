using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class TblUsuarios
    {
        public int IntCodUsuario { get; set; }
        public string StrNomApellidos { get; set; }
        public string StrCargo { get; set; }
        public string StrUsuario { get; set; }
        public string StrPasswd { get; set; }
        public DateTime DtmFechaIngreso { get; set; }
        public bool BlnActivo { get; set; }

        public TblUsuarios() { }

        public TblUsuarios(int intCodUsuario, string strNomApellidos, string strCargo,
                           string strUsuario, string strPasswd, DateTime dtmFechaIngreso, bool blnActivo)
        {
            IntCodUsuario = intCodUsuario;
            StrNomApellidos = strNomApellidos;
            StrCargo = strCargo;
            StrUsuario = strUsuario;
            StrPasswd = strPasswd;
            DtmFechaIngreso = dtmFechaIngreso;
            BlnActivo = blnActivo;
        }
    }

}