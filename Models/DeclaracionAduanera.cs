using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class DeclaracionAduanera
    {
        public int IdDeclaracion { get; set; }
        public int IdPasajero { get; set; }
        public int IdVuelo { get; set; }
        public DateTime FechaDeclaracion { get; set; }
        public string EstadoDeclaracion { get; set; }
        public string Observaciones { get; set; }

        public DeclaracionAduanera() { }

        public DeclaracionAduanera(int idDeclaracion, int idPasajero, int idVuelo, DateTime fechaDeclaracion,
                                   string estadoDeclaracion, string observaciones)
        {
            IdDeclaracion = idDeclaracion;
            IdPasajero = idPasajero;
            IdVuelo = idVuelo;
            FechaDeclaracion = fechaDeclaracion;
            EstadoDeclaracion = estadoDeclaracion;
            Observaciones = observaciones;
        }
    }

}