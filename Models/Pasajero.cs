using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class Pasajero
    {
        public int IdPasajero { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string DocumentoIdentidad { get; set; }
        public string Nacionalidad { get; set; }
        public string Correo { get; set; }
        public string Telefono { get; set; }

        public Pasajero() { }

        public Pasajero(int idPasajero, string nombre, string apellido, string documentoIdentidad,
                        string nacionalidad, string correo, string telefono)
        {
            IdPasajero = idPasajero;
            Nombre = nombre;
            Apellido = apellido;
            DocumentoIdentidad = documentoIdentidad;
            Nacionalidad = nacionalidad;
            Correo = correo;
            Telefono = telefono;
        }
    }

}