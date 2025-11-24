using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace aduana.Models
{
    public class RevisionAduanera
    {
        public int IdRevision { get; set; }
        public int IdDeclaracion { get; set; }
        public DateTime FechaRevision { get; set; }
        public string Resultado { get; set; }
        public int? InspectorId { get; set; }
        public string Observaciones { get; set; }

        public RevisionAduanera() { }

        public RevisionAduanera(int idRevision, int idDeclaracion, DateTime fechaRevision, string resultado,
                                int? inspectorId, string observaciones)
        {
            IdRevision = idRevision;
            IdDeclaracion = idDeclaracion;
            FechaRevision = fechaRevision;
            Resultado = resultado;
            InspectorId = inspectorId;
            Observaciones = observaciones;
        }
    }

}