using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class Mercancia
    {
        public int IdMercancia { get; set; }
        public int IdDeclaracion { get; set; }
        public string Descripcion { get; set; }
        public string Tipo { get; set; }
        public decimal? ValorDeclarado { get; set; }
        public string ResultadoInspeccion { get; set; }

        public Mercancia() { }

        public Mercancia(int idMercancia, int idDeclaracion, string descripcion, string tipo,
                         decimal? valorDeclarado, string resultadoInspeccion)
        {
            IdMercancia = idMercancia;
            IdDeclaracion = idDeclaracion;
            Descripcion = descripcion;
            Tipo = tipo;
            ValorDeclarado = valorDeclarado;
            ResultadoInspeccion = resultadoInspeccion;
        }
    }

}