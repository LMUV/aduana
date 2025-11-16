using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class Notificacion
    {
        public int IdNotificacion { get; set; }
        public int IdPasajero { get; set; }
        public string Tipo { get; set; }
        public string Mensaje { get; set; }
        public DateTime FechaEnvio { get; set; }

        public Notificacion() { }

        public Notificacion(int idNotificacion, int idPasajero, string tipo, string mensaje, DateTime fechaEnvio)
        {
            IdNotificacion = idNotificacion;
            IdPasajero = idPasajero;
            Tipo = tipo;
            Mensaje = mensaje;
            FechaEnvio = fechaEnvio;
        }
    }

}