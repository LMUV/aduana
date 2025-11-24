using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class Vuelo
    {
        public int IdVuelo { get; set; }
        public string NumeroVuelo { get; set; }
        public DateTime FechaLlegada { get; set; }
        public string Origen { get; set; }
        public string Destino { get; set; }
        public string CodigoAerolinea { get; set; }

        public Vuelo() { }

        public Vuelo(int idVuelo, string numeroVuelo, DateTime fechaLlegada, string origen, string destino, string codigoAerolinea)
        {
            IdVuelo = idVuelo;
            NumeroVuelo = numeroVuelo;
            FechaLlegada = fechaLlegada;
            Origen = origen;
            Destino = destino;
            CodigoAerolinea = codigoAerolinea;
        }
    }

}