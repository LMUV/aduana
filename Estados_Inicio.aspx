<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Estados_Inicio.aspx.cs" Inherits="aduana.Estados_Inicio" %>





<!DOCTYPE html>
<html>
<head runat="server">
    <title>Ficha Técnica de Mercancía</title>

    <style>
        body {
            font-family: Arial;
            background: #f4f6f9;
        }

         /* CONTENEDOR DEL ENCABEZADO */
.header-top {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    gap: 20px; /* espacio entre imagen y RO */
    margin-bottom: 25px;
}

/* LOGO IMAGEN */
.logo {
    width: 100px;
    height: 80px;
    object-fit: contain;
}

/* CÍRCULO RO */
.logo-circle {
    width: 100px;
    height: 80px;
    background-color: #004aad;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 28px;
}

        .ficha-container {
            width: 85%;
            margin: 120px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }

        .titulo-principal {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #003366;
            margin-bottom: 15px;
        }

        

        .seccion-titulo {
            font-size: 20px;
            font-weight: bold;
            margin-top: 30px;
            color: #00509e;
            border-left: 6px solid #00509e;
            padding-left: 10px;
            margin-bottom: 10px;
        }

        .fila {
            margin: 8px 0;
            font-size: 16px;
        }

        .etiqueta {
            font-weight: bold;
            width: 240px;
            display: inline-block;
            color: #333;
        }

        .valor {
            color: #111;
        }

        .btn-descargar {
            margin-top: 30px;
            padding: 12px 20px;
            font-size: 18px;
            background: #003366;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-descargar:hover {
            background: #00509e;
        }
         .btn-volver {
     margin-top: 30px;
     padding: 12px 20px;
     font-size: 18px;
     background: #ff6a00;
     color: white;
     border: none;
     border-radius: 6px;
     cursor: pointer;
 }

 .btn-volver:hover {
     background: #ff6a00;
 }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="ficha-container">

         <div class="header-top">
    <img src="Imagenes/dian.png" class="logo" />
    <div class="logo-circle">RO</div>
</div>

           
           <div id="divFicha" runat="server">
            <div class="titulo-principal">FICHA DECLARACION</div>

                         <div class="seccion-titulo">Declaración Aduanera</div>

             <p class="fila"><span class="etiqueta">ID Declaración:</span> 
                 <asp:Label ID="txtIdDeclaracion" CssClass="valor" runat="server" /></p>

             <p class="fila"><span class="etiqueta">Fecha Declaración:</span> 
                 <asp:Label ID="txtFechaDeclaracion" CssClass="valor" runat="server" /></p>

             <p class="fila"><span class="etiqueta">Estado:</span> 
                 <asp:Label ID="txtEstadoDeclaracion" CssClass="valor" runat="server" /></p>

             <p class="fila"><span class="etiqueta">Observaciones:</span> 
                 <asp:Label ID="txtObsDeclaracion" CssClass="valor" runat="server" /></p>



            <div class="seccion-titulo">Datos del Pasajero</div>

            <p class="fila"><span class="etiqueta">Nombre completo:</span> 
                <asp:Label ID="txtPasajero" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Documento:</span> 
                <asp:Label ID="txtDocumento" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Nacionalidad:</span> 
                <asp:Label ID="txtNacionalidad" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Correo:</span> 
                <asp:Label ID="txtCorreo" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Teléfono:</span> 
                <asp:Label ID="txtTelefono" CssClass="valor" runat="server" /></p>

           
            <div class="seccion-titulo">Información del Vuelo</div>

            <p class="fila"><span class="etiqueta">Número de vuelo:</span> 
                <asp:Label ID="txtVuelo" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Fecha de llegada:</span> 
                <asp:Label ID="txtFechaLlegada" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Origen:</span> 
                <asp:Label ID="txtOrigen" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Destino:</span> 
                <asp:Label ID="txtDestino" CssClass="valor" runat="server" /></p>

           

           
            <div class="seccion-titulo">Datos de la Mercancía</div>

            <p class="fila"><span class="etiqueta">Descripción:</span> 
                <asp:Label ID="txtDescripcion" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Tipo:</span> 
                <asp:Label ID="txtTipo" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Valor declarado:</span> 
                <asp:Label ID="txtValor" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Resultado inspección:</span> 
                <asp:Label ID="txtResultadoInspeccion" CssClass="valor" runat="server" /></p>

          
            <div class="seccion-titulo">Revisión Final</div>

            <p class="fila"><span class="etiqueta">Fecha revisión:</span> 
                <asp:Label ID="txtFechaRevision" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Resultado:</span> 
                <asp:Label ID="txtResultadoRevision" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Inspector:</span> 
                <asp:Label ID="txtInspector" CssClass="valor" runat="server" /></p>

            <p class="fila"><span class="etiqueta">Observaciones:</span> 
                <asp:Label ID="txtObsRevision" CssClass="valor" runat="server" /></p>
</div>
            <asp:Button ID="btnDescargar" runat="server" Text="Descargar PDF"
                CssClass="btn-descargar" OnClick="btnDescargar_Click" />

         <br />
            <br />
                <asp:Button ID="btnCancelar" runat="server" CssClass="btn-volver" 
Text="Volver" OnClick="btnCancelar_Click" />

    


    


        </div>

    </form>
</body>
</html>
