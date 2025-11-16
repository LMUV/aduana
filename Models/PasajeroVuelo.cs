using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class PasajeroVuelo
    {
        public int IdPasajero { get; set; }
        public int IdVuelo { get; set; }

        public PasajeroVuelo() { }

        public PasajeroVuelo(int idPasajero, int idVuelo)
        {
            IdPasajero = idPasajero;
            IdVuelo = idVuelo;
        }
    }

}