<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Estados_frm.aspx.cs"
    Inherits="Aduana.Estados_frm" EnableEventValidation="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Inspecciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #e9f1f0;
        }

        .main-card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 25px;
            margin: 30px auto;
            max-width: 1100px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .section-card {
            background-color: #f8f9fa;
            border-left: 6px solid #0008ff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
        }

        h4 {
            background-color: #0008ff;
            color: white;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 30px;
        }

        h5 {
            font-weight: bold;
            color: #007d7d;
            margin-bottom: 15px;
        }

        label span {
            color: red;
        }

        .btn-primary {
            background-color: #007d7d;
            border: none;
        }

        .btn-amarillo2 {
            background-color: #eb9d01;
            border: none;
           
        }

        .btn-secondary {
            background-color: #fb6e09;
            border: none;
        }

        .btn-danger {
            background-color: #e22005;
            border: none;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }


    </style>
</head>
<body>
    <form id="form1" runat="server" class="container">
        <div class="main-card">
            <h4>Realizar Inspeccion</h4>
            <asp:Label ID="lblMensaje" runat="server" CssClass="fw-bold text-center d-block mb-3"></asp:Label>

           
            <div class="section-card">
                <h5>llenar campos de la inspeccion</h5>
                <div class="row g-3">
                    <div class="col-md-3">
                       

                        <label>Código Revision<span>*</span></label>
                        <asp:TextBox ID="txtCodigoInterno" runat="server" CssClass="form-control"  />

                         <label>Código Declaración<span>*</span></label>
                        <asp:TextBox ID="txtdeclaracion" runat="server" CssClass="form-control"   />

                       <label>Fecha Revision</label><asp:TextBox ID="txtfecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox></div>
                         
                          

                    

                 
                        <label>Nombre del Inspector Responsable  <span>*</span></label>
                        <asp:DropDownList ID="ddlreponsable" runat="server" CssClass="form-select" AutoPostBack="true" ></asp:DropDownList>
                    
                    
                    
                  
                        <label>Resultado Inspeccion<span>*</span></label>
                        <asp:DropDownList ID="ddlresultado" runat="server" CssClass="form-select" AutoPostBack="true" ></asp:DropDownList>
                    
                    
                   <label>Observaciones<span>*</span></label>
        <asp:TextBox ID="txtobservar" runat="server" CssClass="form-control"  />
                  
                        

      </div>                  
   </div>      
</div>

              
                                    
           

            <div class="btn-group">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" UseSubmitBehavior="false" />
                <asp:Button ID="btnCancelar" runat="server" Text="Salir" CssClass="btn btn-secondary" OnClick="btnCancelar_Click" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-amarillo2" OnClick="LimpiarCampos" />
 

                <br />
                <br />
            </div>
      
    </form>

    
</body>
</html>
